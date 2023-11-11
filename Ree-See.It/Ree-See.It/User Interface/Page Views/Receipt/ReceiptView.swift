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
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            })
        }
    }
}

#Preview {
    ReceiptView()
}
