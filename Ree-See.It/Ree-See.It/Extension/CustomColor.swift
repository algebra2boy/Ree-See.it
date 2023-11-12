//
//  CustomColor.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
    static var bloodOrange: Color {
        Color(red: 0.87, green: 0.33, blue: 0.25)
    }
    
    static var greenCyan: Color {
        Color(red: 0.258, green: 0.67, blue: 0.454)
    }
    
    static var warm: Color {
        Color(red: 235 / 255.0, green: 197 / 255.0, blue: 183 / 255.0)
    }
    
    static var lightgreen: Color {
        Color(red: 221 / 255.0, green: 222 / 255.0, blue: 197 / 255.0)
    }
    
    static var lightblue: Color {
            Color(red: 213 / 255.0, green: 233 / 255.0, blue: 245 / 255.0)
        }
}

struct NavigationBarTitleColor: ViewModifier {
    var color: UIColor

    init(color: UIColor) {
        self.color = color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: color]
        appearance.largeTitleTextAttributes = [.foregroundColor: color]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
    }
}
