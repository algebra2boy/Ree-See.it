//
//  SignInView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI

struct SignInView: View {
    let action: () -> Void

    var body: some View {
        VStack {
            ZStack {
                Image("SignForegroundImage")
                    .resizable()
                    .scaledToFit()
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Ree See It")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.brown)
                    Spacer()
                }
            }
            .padding()
            HStack {
                Button {
                    // Action for the button
                    action()
                } label: {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                    
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.lightgreen)
    }
}

