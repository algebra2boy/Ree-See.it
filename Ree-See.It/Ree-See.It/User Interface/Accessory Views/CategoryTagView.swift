//
//  CategoryTagView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI

struct CategoryTagView: View {
    
    // Parameters
    
    let categoryTag: String
    let paddingValue: CGFloat
    let backgroundColor: Color
    let foreGroundColor: Color
    let fontSize: CGFloat
    
    init(categoryTag: String = "N/A", paddingValue: CGFloat = 7, backgroundColor: Color = .pink, foreGroundColor: Color = .white, fontSize: CGFloat = 10) {
        self.categoryTag = categoryTag
        self.paddingValue = paddingValue
        self.backgroundColor = backgroundColor
        self.foreGroundColor = foreGroundColor
        self.fontSize = fontSize
    }
    
    var body: some View {
        Text(categoryTag)
            .padding(paddingValue)
            .background(backgroundColor.opacity(0.7))
            .foregroundColor(foreGroundColor)
            .font(.system(size: fontSize))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    CategoryTagView()
}
