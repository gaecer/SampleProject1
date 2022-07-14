//
//  UIColor.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 22/12/2020.
//

import UIKit

/// Colors used inside the app
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static let mainRed = UIColor.rgb(red: 205, green: 33, blue: 14)
    static let textBrightColor = UIColor.rgb(red: 250, green: 250, blue: 250)
    static let darkBackgroundColor = UIColor.rgb(red: 5, green: 5, blue: 5)
    static let buttonColor = UIColor.rgb(red: 61, green: 129, blue: 255)
}
