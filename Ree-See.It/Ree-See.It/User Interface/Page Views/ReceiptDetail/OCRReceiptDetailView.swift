//
//  OCRReceiptDetailView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI
import MapKit


struct OCRReceiptDetailView: View {
    let receipt: Receipt
    
    // Define a state variable for the map region
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("ITEMS")) {
                    ForEach(receipt.item, id: \.name) { item in
                        HStack {
                            Text(item.name)
                                .bold()
                            Spacer()
                            Text(dollarFormatter.string(from: NSNumber(value: item.price)) ?? "$0.00")
                        }
                    }
                }
                Section(header: Text("TOTAL")) {
                    HStack {
                        Text("Total price")
                            .bold()
                        Spacer()
                        Text(dollarFormatter.string(from: NSNumber(value: receipt.totalPrice)) ?? "$0.00")
                    }
                }
                
                Section(header: Text("LOCATION")) {
                    Map {
                        Marker("Receipt", coordinate: CLLocationCoordinate2D(latitude: receipt.coordinate.lat, longitude: receipt.coordinate.long))
                    }
                    .frame(height: 300)
                }
            }
        }
        .navigationTitle("\(receipt.name)")
    }
    
}

#Preview {
    OCRReceiptDetailView(receipt: Receipt.receipt1)
}

