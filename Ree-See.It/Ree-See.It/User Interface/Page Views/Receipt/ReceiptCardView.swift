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
        HStack(spacing: 20) {
            Spacer()
            Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(receipt.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(receipt.category)
            }
            Spacer()
            Spacer()
            
            
            Text(dollarFormatter.string(from: NSNumber(value: receipt.totalPrice)) ?? "$0.00")
                .font(.title2)
            Spacer()
        }
    }
}

#Preview {
    
    let receipt: Receipt = Bundle.main.decode("MockReceiptData.json")[0]
    ReceiptCardView(receipt: receipt)
}
