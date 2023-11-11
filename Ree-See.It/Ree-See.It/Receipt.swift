//
//  Receipt.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import Foundation

struct Receipt: Codable, Identifiable, Hashable {
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


struct Item: Codable, Hashable {
    var name: String
    var price: Double
}


extension Receipt {
    static let receipt1 = Receipt(id: UUID(),
                                  name: "Costco",
                                  address: "Boston",
                                  date: "2023-10-11",
                                  item: [],
                                  totalPrice: 129.99,
                                  category: "food",
                                  message: "why is food so expensive",
                                  isVerified: false,
                                  receiptMethod: "API")

    static let receipt2 = Receipt(id: UUID(),
                                  name: "Walmart",
                                  address: "Cambridge",
                                  date: "2023-10-12",
                                  item: [],
                                  totalPrice: 88.76,
                                  category: "household",
                                  message: "Got a discount",
                                  isVerified: true,
                                  receiptMethod: "Manual")

    static let receipt3 = Receipt(id: UUID(),
                                  name: "Target",
                                  address: "Somerville",
                                  date: "2023-10-13",
                                  item: [],
                                  totalPrice: 57.45,
                                  category: "electronics",
                                  message: "Needed a new mouse",
                                  isVerified: false,
                                  receiptMethod: "OCR")

    static let receipt4 = Receipt(id: UUID(),
                                  name: "Best Buy",
                                  address: "Quincy",
                                  date: "2023-10-14",
                                  item: [],
                                  totalPrice: 204.99,
                                  category: "electronics",
                                  message: "New headphones",
                                  isVerified: true,
                                  receiptMethod: "API")

    static let receipt5 = Receipt(id: UUID(),
                                  name: "Trader Joe's",
                                  address: "Arlington",
                                  date: "2023-10-15",
                                  item: [],
                                  totalPrice: 150.23,
                                  category: "groceries",
                                  message: "Weekly groceries",
                                  isVerified: true,
                                  receiptMethod: "Manual")
}

