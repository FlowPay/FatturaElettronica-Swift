

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
        try container.encode(self.wrappedValue)
    }
}

extension KeyedDecodingContainer {
    public func decode(_ type: PABool.Type, forKey key: Self.Key) throws -> PABool {
        return try decodeIfPresent(type, forKey: key) ?? PABool(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode(_ value: PABool, forKey key: Self.Key) throws {
        if value.wrappedValue != nil {
            try value.encode(to: self.superEncoder(forKey: key))
        }
    }
}