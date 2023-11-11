//
//  NumberFormatter.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import Foundation

let dollarFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()
