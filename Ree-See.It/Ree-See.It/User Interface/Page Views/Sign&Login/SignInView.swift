//
//  SignInView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI

struct SignInView: View {
//    let action: () -> Void
    let action: () -> Void

    var body: some View {
        VStack {
            Spacer()

            Spacer()

            Spacer()
            VStack {
                Image("SignForegroundImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Ree See It")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.brown)
            }
            .padding()
            Spacer()
            Spacer()
            Spacer()
                Button {
                    // Action for the button
                    action()
                } label: {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                    
                }
                .buttonStyle(.borderedProminent)
                .accentColor(Color.brown)
                .padding()
            Spacer()
            Spacer()


        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.lightgreen)
    }
}

//#Preview {
//    SignInView()
//}

