//
//  ImageTableViewCellModel.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 27/12/2020.
//

import UIKit

struct ImageTableViewCellModel {
    var isLoading: Bool = false
    var title: String?
    var description: String?
    var price: Int
    var image: UIImage
    var greetingType: GreetingType?
}
