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
            Spacer()
            Image(systemName: "doc.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .shadow(radius: 10)
                .offset(x: -15)
                .padding(.top, 50)
            
            Text("Please press on \"+\" on the top right to add your receipt")
                .font(.system(.title, weight: .light))
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
        
        }
    }
}

#Preview {
    EmptyReceiptView()
}
