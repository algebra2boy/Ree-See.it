//
//  ReceiptView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI

struct ReceiptView: View {
    @State private var receipts: [Receipt] = [.receipt1, .receipt2, .receipt3, .receipt4, .receipt5]

    var body: some View {
        NavigationStack {
            List {
                ForEach(receipts, id: \.id) { receipt in
                    ReceiptCardView(receipt: receipt)
                }
                .onDelete(perform: deleteReceipt)
                .listRowBackground(
                    Capsule()
                        .fill(Color(white: 1, opacity: 0.8))
                        .padding(3)
                )
                .listRowSeparator(.hidden)
            }
            
            .navigationTitle("Receipts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Action for the leading button
                    }) {
                        Image(systemName: "person.circle")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action for the trailing button
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }

    private func deleteReceipt(at offsets: IndexSet) {
        receipts.remove(atOffsets: offsets)
    }
}


#Preview {
    ReceiptView()
}
