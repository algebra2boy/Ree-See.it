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
    
    @State private var filteredReceipts: [Receipt] = []
    
    @State private var hasItemDeleted: Bool = false
    @State private var toBeDeleted: IndexSet?
    @State private var isLogoPressed: Bool = false
    @State private var searchText: String = ""
    
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        NavigationStack {
            Group {
                if receipts.isEmpty {
                    EmptyReceiptView()
                } else {
                    List {
                        ForEach(filteredReceipts.count > 0 ? filteredReceipts : receipts, id: \.id) { receipt in
                            ReceiptCardView(receipt: receipt)
                                Group {
                                    if receipt.isVerified {
                                        NavigationLink {
                                            OCRReceiptDetailView(receipt: receipt)
                                        } label: {
                                            ReceiptCardView(receipt: receipt)
                                        }
                                    } else {
                                        ReceiptCardView(receipt: receipt)
                                    }
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
                    .searchable(text: $searchText, prompt: "Search for receipt")
                    .onChange(of: searchText) {
                        filterReceipt()
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
        
        func deleteReceipt(at offsets: IndexSet) {
            receipts.remove(atOffsets: offsets)
        }
        
        func filterReceipt() {
            filteredReceipts = receipts.filter { $0.name.localizedCaseInsensitiveContains(searchText.lowercased()) ||
                $0.category.localizedCaseInsensitiveContains(searchText.lowercased())
            }
        }
        
    }
}



//#Preview {
//    ReceiptView()
//        .environmentObject(AuthenticationManager())
//}
