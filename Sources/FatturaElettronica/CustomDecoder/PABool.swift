

@propertyWrapper
public struct PABool: Codable {

    public var wrappedValue: Bool?

    public init(wrappedValue: Bool?) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let bool = try? container.decode(Bool.self) {
            self.wrappedValue = bool
        } else if let string = try? container.decode(String.self) {
            
            switch string.lowercased() {
            case "si", "true", "s": self.wrappedValue = true
            default: self.wrappedValue = false
            }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Impossible to decode Bool")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
    /// https://www.fatturapa.gov.it/it/norme-e-regole/documentazione-fattura-elettronica/formato-fatturapa/
    /// As of documentation this value if true must be encoded as "SI".
    /// and in case of false the value is not encoded
        if let bool = self.wrappedValue,
           bool {
            try container.encode("SI")
        }
    }
}

extension KeyedDecodingContainer {
    public func decode(_ type: PABool.Type, forKey key: Self.Key) throws -> PABool {
        return try decodeIfPresent(type, forKey: key) ?? PABool(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode(_ value: PABool, forKey key: Self.Key) throws {
        if let bool = value.wrappedValue, bool {
            try value.encode(to: self.superEncoder(forKey: key))
        }
    }
}