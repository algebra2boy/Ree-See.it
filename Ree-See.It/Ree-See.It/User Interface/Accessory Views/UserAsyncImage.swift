//
//  UserAsyncImage.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//
import SwiftUI

struct UserAsyncImage: View {
    
    let imageUrl: String?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "https://d112y698adiu2z.cloudfront.net/photos/production/challenge_photos/000/308/828/datas/full_width.png")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: width, height: height)
        .cornerRadius(60)
    }
}
