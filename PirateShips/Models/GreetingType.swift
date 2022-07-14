//
//  GreetingType.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 31/12/2020.
//

import Foundation

/// Enum to enumerate all the Greeting types
enum GreetingType {
    case ah, ay, ar, yo, unknown
}

/// Extension to Decode the Greeting types
extension GreetingType: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "ah": self = .ah
        case "ay": self = .ay
        case "ar": self = .ar
        case "yo": self = .yo
        default: self = .unknown
        }
    }
}

/// Extension to GreetingType Enum to translate the code to a string description
extension GreetingType {
    func description() -> String {
        switch self {
        case .ay:
            return "Aye Aye!"
        case .ar:
            return "Arrr!"
        case .yo:
            return "Yo ho hooo!"
        default:
            return "Ahoi!"
        }
    }
}

/// Extension to conform the GreetingType to the Equatable protocol
extension GreetingType: Equatable {
    static func ==(lhs: GreetingType, rhs: GreetingType) -> Bool {
        switch (lhs, rhs) {
        case (.ah, .ah), (.ay, .ay), (.ar, .ar), (.yo, .yo), (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
