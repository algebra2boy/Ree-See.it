//
//  Profile.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI

struct ProfileCell: View {
    @State var key: String
    @State var value: String

    private let size: CGFloat = 14

    var body: some View {
        HStack {
            Text(key)
                .font(.system(size: self.size, weight: .semibold))
            Spacer()
            Text(value)
                .font(.system(size: self.size, weight: .regular))
            #if os(iOS)
                .foregroundColor(Color("Grey"))
            #endif
        }
    #if os(iOS)
        .listRowBackground(Color.white)
    #endif
    }
}

struct ProfileHeader: View {
    @State var picture: String

    private let size: CGFloat = 100

    var body: some View {
    #if os(iOS)
        AsyncImage(url: URL(string: picture), content: { image in
            image.resizable()
        }, placeholder: {
            Color.clear
        })
        .frame(width: self.size, height: self.size)
        .clipShape(Circle())
        .padding(.bottom, 24)
    #else
        Text("Profile")
    #endif
    }
}
