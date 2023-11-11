//
//  EmptyReceiptView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/10/23.
//

import SwiftUI

struct EmptyReceiptView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .shadow(radius: 10)
                .offset(x: -15)
                .padding(.top, 50)
            
            Text("Add your receipt")
                .font(.system(.title2, weight: .semibold))
        
        }
    }
}

#Preview {
    EmptyReceiptView()
}
