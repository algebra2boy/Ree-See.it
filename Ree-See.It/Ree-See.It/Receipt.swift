//
//  Receipt.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import Foundation

struct Receipt: Codable, Identifiable {
    var id: UUID
    var name: String
    var address: String
//    var coordinate:
    
    var date: String
    
    var item: [Item]
    var totalPrice: Double
    var category: String
    var message: String
    
    // used for API verification
    var isVerified: Bool
    
    // API, TEXT, OCR
    var receiptMethod: String
    
    init(id: UUID, name: String, address: String, date: String, item: [Item], totalPrice: Double, category: String, message: String, isVerified: Bool, receiptMethod: String) {
        self.id = id
        self.name = name
        self.address = address
        self.date = date
        self.item = item
        self.totalPrice = totalPrice
        self.category = category
        self.message = message
        self.isVerified = isVerified
        self.receiptMethod = receiptMethod
    }
}


struct Item: Codable {
    var name: String
    var price: Double
}


extension Receipt {
    static let receipt1 = Receipt(id: UUID(),
                                  name: "costco",
                                  address: "boston",
                                  date: "2023-10-11",
                                  item: [],
                                  totalPrice: 129.99,
                                  category: "food",
                                  message: "why is food so expensive",
                                  isVerified: false,
                                  receiptMethod: "API")
}
