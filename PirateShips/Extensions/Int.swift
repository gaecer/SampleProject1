//
//  Int.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 24/12/2020.
//

import Foundation

extension Int {
    /// This function will transform a number into a string appending the current valuta symbol
    func formattedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? "£\(self)"
    }
}
