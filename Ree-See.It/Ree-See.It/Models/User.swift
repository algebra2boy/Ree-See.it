//
//  User.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI
import JWTDecode

// User class as ObservableObject
class User: ObservableObject {
    @Published var id: String
    @Published var name: String
    @Published var email: String
    @Published var emailVerified: Bool
    @Published var picture: String
    @Published var updatedAt: String

    init?(from idToken: String) {
        guard let jwt = try? decode(jwt: idToken),
              let id = jwt.subject,
              let name = jwt["name"].string,
              let email = jwt["email"].string,
              let emailVerified = jwt["email_verified"].boolean,
              let picture = jwt["picture"].string,
              let updatedAt = jwt["updated_at"].string else {
            return nil
        }
        self.id = id
        self.name = name
        self.email = email
        self.emailVerified = emailVerified
        self.picture = picture
        self.updatedAt = updatedAt
    }
}

// Authentication manager to handle the user state
class AuthenticationManager: ObservableObject {
    @Published var user: User?
}
