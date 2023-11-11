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
                UserAsyncImage(imageUrl: user?.picture, width: 100, height: 100)
                
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

