//
//  XMLOneof.swift
//  
//
//  Created by Federico Giuntoli on 29/08/20.
//

import Foundation

extension Array where Element: Codable {
    init(from decoder: Decoder) throws {
        
        if let many = try? decoder.singleValueContainer().decode([Element].self){
            self = many
            return
        }
        
        if let one = try? decoder.singleValueContainer().decode(Element.self){
            self = [one]
            return
        }
        
        throw DecodingError.missingValue
    }
    enum DecodingError: Error {
        case missingValue
    }
}
