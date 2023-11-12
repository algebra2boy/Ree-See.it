//
//  SignLoginView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI
import Auth0

struct SignLoginView: View {
    
    
    @EnvironmentObject var authManager: AuthenticationManager


    var body: some View {
        // already login in
        if let user = self.authManager.user {
            VStack {
                ProfileView(user: user, action: self.logout)
            }
        } else {
            SignInView(action: self.login)
        }
    }
}

extension SignLoginView {
    func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    self.authManager.user = User(from: credentials.idToken)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    self.authManager.user = nil
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
}
