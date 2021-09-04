//
//  File.swift
//  
//
//  Created by Andrea Pini on 23/09/20.
//

import Foundation
import NIO
import XMLCoder

extension Date{
    class FormatterError: Error {}
    
    init(from value: String, formatter: String) throws{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        guard let date = dateFormatter.date(from: value) else { throw FormatterError() }
        self = date
    }
}

public class XMLHandler{
    let eventLoop: EventLoop
    let decoder = XMLDecoder()

    public convenience init() {
        let loop = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount).next()
        self.init(on: loop)
    }
    
    struct XMLKey: CodingKey {
        var stringValue: String

        init(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int? = nil

        init?(intValue: Int) {
            nil
        }


    }

    public init(on loop: EventLoop){
        self.eventLoop = loop
        self.decoder.shouldProcessNamespaces = true
        
        self.decoder.dateDecodingStrategy = .custom {
            let container = try $0.singleValueContainer()
            let string = try container.decode(String.self)
            
            if let date = try? Date(from: string, formatter: "yyyy-MM-dd"){
                return date
            }
            // Dati generali / Dati Trasporto / Data ora consegna
            else if let date = try? Date(from: string, formatter: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"){
                return date
            } else if let date = try? Date(from: string, formatter: "yyyy-MM-dd'T'HH:mm:ss") {
                return date
            } else if let date = ISO8601DateFormatter().date(from: string) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "couldn't create a date from \(string)")
            }
        }
        self.decoder.keyDecodingStrategy = .custom { codingPath in
            let last = codingPath.last!
            let loweCasedKey = last.stringValue.lowercased()
            return XMLKey(stringValue: loweCasedKey)
        }
    }
    
    func xmlToInvoice(_ xml: String) -> EventLoopFuture<FatturaElettronica>{
        let loop = self.eventLoop.next()

            let promise = loop.makePromise(of: FatturaElettronica.self)
            let _ = loop.submit{
                guard
                    let data = xml.data(using: .utf8) else {
                    promise.fail(IOError(errnoCode: 0, reason: "Da codificare"))
                    return
                }
                
                let invoice = try self.decoder.decode(FatturaElettronica.self, from: data)
               
                promise.succeed(invoice)
            }.cascadeFailure(to: promise)
        
            return promise.futureResult
            
        }
        
        private func shell(command: String) -> String? {
            let process = Process()
            process.launchPath = "/bin/sh/"
            process.arguments = ["-c", command]
            let pipe = Pipe()
            process.standardOutput = pipe
            process.launch()
            let output_from_command = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)

            if let output = output_from_command, output.count > 0 {
                let lastIndex = output.index(before: output.endIndex)
                return String(output[output.startIndex ..< lastIndex])
            }
            return output_from_command
        }
        
        func unzip(_ url: URL) -> EventLoopFuture<Void>{
            let loop = self.eventLoop.next()
            let promise = loop.makePromise(of: Void.self)
            
            let path = url.absoluteString.replacingOccurrences(of: "file://", with: "")
            loop.submit{
                _ = self.shell(command: "unzip -o \(path) -d \(url.pathComponents.dropLast().joined(separator: "/"))")
                promise.succeed(())
            }.cascadeFailure(to: promise)
            
            return promise.futureResult
        }
        
        func decryptP7M(filePath path: URL) -> EventLoopFuture<String> {
            let loop = self.eventLoop.next()
            let promise = loop.makePromise(of: String.self)
            
            loop.submit{
                
                let p7mPath = path.absoluteString.replacingOccurrences(of: "file://", with: "")
                
                
                let command = "openssl smime -decrypt -verify -inform DER -in \(p7mPath) -noverify -out \(p7mPath).xml"
                
                _ = self.shell(command: command)
                
                let content = try String(contentsOfFile: p7mPath+".xml", encoding: .utf8)
                let _ = try FileManager.default.removeItem(atPath: p7mPath + ".xml")
                
                promise.succeed(content)
            }.cascadeFailure(to: promise)
            
            return promise.futureResult
        }

}
