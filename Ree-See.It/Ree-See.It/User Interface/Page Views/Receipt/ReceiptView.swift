//
//  ReceiptView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI

struct ReceiptView: View {
    @State private var receipts: [Receipt] = [.receipt1, .receipt2, .receipt3, .receipt4, .receipt5]
    
    @State private var hasItemDeleted: Bool = false
    @State private var toBeDeleted: IndexSet?
    
    var body: some View {
        NavigationStack {
            Group {
                if receipts.isEmpty {
                    EmptyReceiptView()
                } else {
                    
                    List {
                        ForEach(receipts, id: \.id) { receipt in
                            ReceiptCardView(receipt: receipt)
                        }
                        .onDelete(perform: deleteReceipt)
                        .listRowBackground(
                            RoundedRectangle(
                                cornerSize: CGSize(width: 20, height: 10))
                            .fill(Color(white: 1, opacity: 0.8))
                            .padding(3)
                        )
                        .listRowSeparator(.hidden) // hide the line
                    }
                }
            }
            
            .navigationTitle("Receipts")
            .alert("Do you want to delete this receipt on the cloud?", isPresented: $hasItemDeleted) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    receipts.remove(atOffsets: toBeDeleted!)
                }
            }
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
                    NavigationStack {
                        Menu {
                            
                            SelectionMenu()
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
        
        
    }
    
    func deleteReceipt(at offsets: IndexSet) {
        
        self.hasItemDeleted = true
        self.toBeDeleted = offsets
        
    }
}


#Preview {
    ReceiptView()
}
