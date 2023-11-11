//
//  ReceiptView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI

struct ReceiptView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle("Receipt")
            .toolbar(content: {
            
                Menu {
                    SelectionMenu()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                }
            })
            
            
        }
    }
}

#Preview {
    ReceiptView()
}
