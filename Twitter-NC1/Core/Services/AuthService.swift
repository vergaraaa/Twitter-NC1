//
//  AuthService.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 15/11/23.
//

import Firebase
import Foundation
import FirebaseFirestore

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            try await UserService.shared.fetchCurrentUser()
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to create user with errro \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            try await uploadUserData(id: result.user.uid, email: email, fullname: fullname, username: username)
            
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut() // signs out on backend
        self.userSession = nil // removes session locally and updates routing
        UserService.shared.reset() // set current user object to nil
    }
    
    @MainActor
    private func uploadUserData(
        id: String,
        email: String,
        fullname: String,
        username: String
    ) async throws {
        let user = User(id: id, fullname: fullname, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        
        UserService.shared.currentUser = user
    }
}
