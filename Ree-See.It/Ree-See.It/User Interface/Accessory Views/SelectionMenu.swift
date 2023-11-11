//
//  SelectionMenu.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI

struct SelectionMenu: View {
    var body: some View {
        SelectionItem(label: "Add Receipt", image: "list.clipboard")
        SelectionItem(label: "Scan Receipt", image: "doc.viewfinder")
    }
}

struct SelectionItem: View {
    
    let label: String
    let image: String
    
    var body: some View {
        Button {
            
        } label: {
            Label(label, systemImage: image)
        }
        .labelStyle(.titleAndIcon)
    }
}

#Preview {
    SelectionMenu()
}
