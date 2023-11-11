//
//  HeroView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//
import SwiftUI

struct HeroView: View {
    private let tracking: CGFloat = -4

    var body: some View {
    #if os(iOS)
        Image("Auth0")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 28, alignment: .center)
            .padding(.top, 8)
        VStack(alignment: .leading, spacing: -32) {
            Text("Swift")
                .tracking(self.tracking)
                .foregroundStyle(
                    .linearGradient(
                      colors: [Color("Orange"), Color("Pink")],
                      startPoint: .topLeading,
                      endPoint: .bottomTrailing
                    ))
            Text("Sample")
                .tracking(self.tracking)
            Text("App")
                .tracking(self.tracking)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .font(.custom("SpaceGrotesk-Medium", size: 80))
    #else
        Text("Ree-See.it")
            .font(.title)
    #endif
    }
}

