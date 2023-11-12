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
                            Group {
                                if receipt.receiptMethod == "OCR" {
                                    NavigationLink {
                                        OCRReceiptDetailView(receipt: receipt)
                                    } label: {
                                        ReceiptCardView(receipt: receipt)
                                    }
                                } else {
                                    ReceiptCardView(receipt: receipt)
                                }
                            }
                        }
                        .onDelete(perform: deleteReceipt)
                        .listRowBackground(
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                                .fill(Color(white: 1, opacity: 0.8))
                                .padding(3)
                        )
                        .listRowSeparator(.hidden)
                    }
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
                    if let offsets = toBeDeleted {
                        receipts.remove(atOffsets: offsets)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SignLoginView()
                    } label: {
                        HStack {
                            UserAsyncImage(imageUrl: authManager.user?.picture, width: 40, height: 40)
                            Text("Hi, \(authManager.user?.name ?? "welcome to Ree See it")").foregroundStyle(Color.primary)
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
        .task {
            do {
                receipts = try await fetchReceipts()
                print(receipts)
            } catch {
                print(error)
            }
        }
        .refreshable {
            do {
                receipts = try await fetchReceipts()
            } catch {
                print(error)
            }
        }
    }
    
    func deleteReceipt(at offsets: IndexSet) {
        toBeDeleted = offsets
        hasItemDeleted = true
    }
    
    func filterReceipt() {
        filteredReceipts = receipts.filter { $0.name.localizedCaseInsensitiveContains(searchText.lowercased()) ||
            $0.category.localizedCaseInsensitiveContains(searchText.lowercased())
        }
    }
    
    func fetchReceipts() async throws -> [Receipt] {
        let url = URL(string: "http://localhost:3004/api/receipt/1234")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(Receipts.self, from: data)
        
        return decoded.receipts
        
    }
}

//struct NotLoginView: View {
//    var body: some View {
//        Text("You have to login in order to see your receipts")
//            .multilineTextAlignment(.center)
//    }
//}


#Preview {
    ReceiptView()
        .environmentObject(AuthenticationManager())
}
