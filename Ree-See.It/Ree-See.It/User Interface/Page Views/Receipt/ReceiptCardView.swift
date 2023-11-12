//
//  ReceiptCardView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI

struct ReceiptCardView: View {
    let receipt: Receipt
    var body: some View {
        HStack {
            Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(.primary) // Use the primary color for the icon

            VStack(alignment: .leading, spacing: 4) { // Reduced spacing
                Text(receipt.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                CategoryTagView(categoryTag: receipt.category, backgroundColor: .warm, foreGroundColor: .primary)
            }
            
            Spacer() // Push everything to the left and price to the right
            
            Text(dollarFormatter.string(from: NSNumber(value: receipt.totalPrice)) ?? "$0.00")
                .font(.body) // Adjusted to .body for better balance with the rest of the content
                .padding(.trailing, 16) // Add padding to the trailing edge
        }
        .frame(height: 60) // Give a fixed height to each card
        .background(Color(UIColor.systemBackground)) // Use the system background color
        .cornerRadius(10) // Round the corners

    }
}


#Preview {
    ReceiptCardView(receipt: Receipt.receipt1)
}
