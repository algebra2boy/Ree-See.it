//
//  ReceiptView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI
import Auth0

struct ReceiptView: View {
    @State private var receipts: [Receipt] = [.receipt1, .receipt2, .receipt3, .receipt4, .receipt5]
    
    @EnvironmentObject var authManager: AuthenticationManager


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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SignLoginView()
                    } label: {
                        HStack {
                            UserAsyncImage(imageUrl: authManager.user?.picture, width: 40, height: 40)
                            
                            Text("Hi, \(authManager.user?.name ?? "welcome to Ree See it")")
                        }
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

    private func deleteReceipt(at offsets: IndexSet) {
        receipts.remove(atOffsets: offsets)
    }
}


#Preview {
    ReceiptView()
        .environmentObject(AuthenticationManager())
}
