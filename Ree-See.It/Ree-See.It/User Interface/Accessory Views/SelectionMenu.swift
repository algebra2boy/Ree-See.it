//
//  SelectionMenu.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI

struct SelectionMenu: View {
    var body: some View {
        SelectionItem(selection: .text)
        SelectionItem(selection: .ocr)
    }
}

struct SelectionItem: View {
    
    let selection: Selection
    
    var body: some View {
        NavigationLink {
            selection.destination
            
        } label: {
            selection.label
        }
        .labelStyle(.titleAndIcon)
    }
}

enum Selection {
    case text
    case ocr
    
    var id: Selection { return self }
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .ocr:
            Label("Scan Receipt", systemImage: "doc.viewfinder")
        case .text:
            Label("Add Receipt", systemImage: "list.clipboard")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .text:
            ReceiptTextFormOptionView()
        case .ocr:
            Text("HELLO, world")
        }
    }
    
}

#Preview {
    SelectionMenu()
}
