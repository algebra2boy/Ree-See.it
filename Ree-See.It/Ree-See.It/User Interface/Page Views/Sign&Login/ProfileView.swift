//
//  ProfileView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//
import SwiftUI

struct ProfileView: View {
    let user: User?
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                AsyncImage(url: URL(string: user?.picture ?? "https://docs-assets.developer.apple.com/published/ac1785229105c7feaff999aafe6303b3/AsyncImage-1~dark@2x.png")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .cornerRadius(60)
                
                Text(user?.name ?? "Test user")
                    .font(.system(size: 25))
                Text(user?.email ?? "hackathon@umass.edu")
                    .font(.subheadline)
            }
            .padding(20)
            
            Spacer()
                
            VStack {
                HStack {
                    Button {
                        action()
                    } label: {
                        Text("Sign Out")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            
            Spacer()
            
        }
        
    }
    
}

//#Preview {
//    HeroView()
//}

