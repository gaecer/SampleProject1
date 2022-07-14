//
//  Ship.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 21/12/2020.
//

import Foundation
import UIKit

/// struct to map the http Response
struct PirateShipResponse: Decodable {
    let ships: [PirateShipModel?]
}

/// struct to map the model needed inside the app
struct PirateShipModel: Decodable {
    public let title: String?
    public let price: Int
    public let image: String
    public let description: String?
    public let greetingType: GreetingType?

    private enum CodingKeys: String, CodingKey {
        case title
        case price
        case image
        case description
        case greetingType = "greeting_type"
    }
}
