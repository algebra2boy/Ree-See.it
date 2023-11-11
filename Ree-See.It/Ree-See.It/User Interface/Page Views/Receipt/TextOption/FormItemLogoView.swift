//
//  FormItemLogoView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/11/23.
//

import SwiftUI

struct FormItemLogoView: View {
    
    let imageName: String
    let rowLabel: String
    let rowTintColor: Color
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 30, height: 30)
                .foregroundStyle(rowTintColor)
                .overlay {
                    Image(systemName: imageName)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
            Text(rowLabel)
        }
    }
}

#Preview {
    FormItemLogoView(imageName: "apple.logo", rowLabel: "apple", rowTintColor: .red)
}
