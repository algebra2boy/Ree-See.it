//
//  SearchBar.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI

/// a view modifier that is used for customize the top bar leading logo and brand name
struct SearchBarStyleModifier: ViewModifier {
    let title: String
    let titleImage: String
    @Binding var isLogoPressed: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: titleImage)
                            .symbolEffect(.bounce.up, value: isLogoPressed)
                        Text(title)
                            .fontDesign(.monospaced)
                    }
                    .onTapGesture {
                        withAnimation {
                            isLogoPressed.toggle()
                        }
                    }
                    .font(.system(size: 25))
                }
            }
    }
}

extension View {
    @ViewBuilder
    public func searchBar(title: String, titleImage: String = "newspaper", isLogoPressed: Binding<Bool>) -> some View {
        self.modifier(SearchBarStyleModifier(title: title, titleImage: titleImage, isLogoPressed: isLogoPressed))
    }
}
