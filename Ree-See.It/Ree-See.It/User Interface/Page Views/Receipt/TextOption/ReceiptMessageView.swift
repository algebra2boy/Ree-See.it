//
//  ReceiptMessageView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/11/23.
//

import SwiftUI

struct ReceiptMessageView: View {
    
    @Binding var note: String
    var body: some View {
        
        NavigationStack {
            VStack {
                TextEditor(text: $note)
                    .foregroundStyle(.secondary)
                    .navigationTitle("Leave a note to you receipt")
                    .submitLabel(.done)
            }
            .navigationTitle("New receipt")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


