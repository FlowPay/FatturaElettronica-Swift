//
//  File.swift
//  
//
//  Created by Federico Giuntoli on 09/10/20.
//

import Foundation
import NIO

extension XMLHandler{
    
    public enum FileType{
        case xml
        case p7m
        case zip
    }
    
    private enum HandlerError: Error{
        case contentNotValid
        case fileNotFound
    }
    
    public func handle(_ file: Data, type: FileType) -> EventLoopFuture<FatturaElettronica> {
        switch type {
        case .p7m:
            return handleP7m(file)
        case .xml:
            return handleXML(file)
        case .zip:
            return handleZip(file)
        }
    }
    
    public func handle(_ xml: String) -> EventLoopFuture<FatturaElettronica> {
        return self.xmlToInvoice(xml)
    }

    public func encode(_ invoice: FatturaElettronica) throws -> Data {
        try self.invoiceToXML(invoice)
    }
    
    private func handleXML(_ data: Data) -> EventLoopFuture<FatturaElettronica> {
        self.eventLoop.submit{
            let content: String? = String(data: data, encoding: .utf8) ?? String(data: data, encoding: .ascii)
            
            guard let content = content else { throw HandlerError.contentNotValid }
            return content
        }.flatMap{
            return self.xmlToInvoice($0)
        }
    }
    
    private func handleP7m(_ data: Data) -> EventLoopFuture<FatturaElettronica>{
        let root = "./" + UUID().uuidString + "/"
        let promise = self.eventLoop.submit{
            try FileManager.default.createDirectory(atPath: root, withIntermediateDirectories: true)
            let p7m = URL(fileURLWithPath: root + "invoice.xml.p7m")
            try data.write(to: p7m)
            return p7m
        }.flatMap{
            self.decryptP7M(filePath: $0)
        }.flatMap{
            self.xmlToInvoice($0)
        }
        
        promise.whenComplete{ _ in
            try? FileManager.default.removeItem(atPath: root)
        }
        
        return promise
        
    }
    private func handleZip(_ data: Data) -> EventLoopFuture<FatturaElettronica>{
        
        let root = "./" + UUID().uuidString + "/"
        let promise = self.eventLoop.submit{
            try FileManager.default.createDirectory(atPath: root, withIntermediateDirectories: true)
            let zip = URL(fileURLWithPath: root + "archive.zip")
            try data.write(to: zip)
            return zip
        }
        .flatMap{
            self.unzip($0)
        }
        .map{
            FileManager.default.enumerator(atPath: root)?
                .allObjects
                .compactMap {$0 as? String }
                .filter{ $0.hasSuffix(".p7m") }
                .map { URL(fileURLWithPath: root + $0) }
                .first
        }
        .unwrap(orError: HandlerError.fileNotFound)
        .flatMap{
            self.decryptP7M(filePath: $0)
        }.flatMap{
            self.xmlToInvoice($0)
        }
        
        promise.whenComplete{ _ in
            try? FileManager.default.removeItem(atPath: root)
        }
        
        return promise
    }
}
