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
    var coordinate: Coordinate
    
    var date: String
    
    var item: [Item]
    var totalPrice: Double
    var category: String
    var message: String
    
    var imageLink: String?
    
    // used for API verification
    var isVerified: Bool
    
    // API, TEXT, OCR
    var receiptMethod: String
    
    init(id: UUID, 
         name: String,
         address: String,
         coordinate: Coordinate, date: String, item: [Item], totalPrice: Double, category: String, message: String, isVerified: Bool, receiptMethod: String) {
        self.id = id
        self.name = name
        self.address = address
        self.coordinate = coordinate
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

struct Coordinate: Codable, Hashable {
    var lat: Double
    var long: Double
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
}

extension Receipt {
    static let receipt1 = Receipt(id: UUID(),
                                  name: "Costco",
                                  address: "Boston",
                                  coordinate: .init(lat: 42.3601, long: -71.057083),
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
                                  coordinate: .init(lat: 42.3601, long: -71.057083),
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
                                  coordinate: .init(lat: 42.3601, long: -71.057083),
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
                                  coordinate: .init(lat: 42.3601, long: -71.057083),
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
                                  coordinate: .init(lat: 42.3601, long: -71.057083),
                                  date: "2023-10-15",
                                  item: [],
                                  totalPrice: 150.23,
                                  category: "groceries",
                                  message: "Weekly groceries",
                                  isVerified: true,
                                  receiptMethod: "Manual")
}


extension Collection where Element == Receipt {
    func mostExpensiveCategory() -> (category: String, totalSpent: Double)? {
        var categoryTotals = [String: Double]()

        // Aggregate total spending per category
        for receipt in self {
            categoryTotals[receipt.category, default: 0] += receipt.totalPrice
        }

        // Find the category with the highest spending and map the result
        return categoryTotals.max(by: { $0.value < $1.value })
                   .map { (category: $0.key, totalSpent: $0.value) }
    }
}
