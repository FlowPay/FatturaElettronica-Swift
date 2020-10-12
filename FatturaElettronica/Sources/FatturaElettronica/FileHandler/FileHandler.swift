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
    
    private func handleXML(_ data: Data) -> EventLoopFuture<FatturaElettronica> {
        self.eventLoop.submit{
            guard let content = String(data: data, encoding: .utf8) else { throw HandlerError.contentNotValid }
            return content
        }.flatMap{
            return self.xmlToInvoice($0)
        }
    }
    
    private func handleP7m(_ data: Data) -> EventLoopFuture<FatturaElettronica>{
        self.eventLoop.submit{
            let uuid = UUID().uuidString
            return URL(fileURLWithPath: "./\(uuid)")
        }.flatMap{
            self.decryptP7M(filePath: $0)
        }.flatMap{
            self.xmlToInvoice($0)
        }
        
    }
    private func handleZip(_ data: Data) -> EventLoopFuture<FatturaElettronica>{
        
        self.eventLoop.submit{
            let uuid = UUID().uuidString
            let p7mPath = URL(fileURLWithPath: "./\(uuid)")
            let zip = URL(fileURLWithPath: "./\(uuid).zip")
            let _ = try data.write(to: zip)
            return (p7mPath, zip)
        }.flatMap{ (p7m: URL, zip: URL) in
            self.unzip(zip).map{ p7m }
        }.flatMap{
            self.decryptP7M(filePath: $0)
        }.flatMap{
            self.xmlToInvoice($0)
        }
        
    }
}
