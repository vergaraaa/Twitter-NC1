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
    @Published var currentUser: User?
    @Published var loading: Bool = true
    
    static let shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws -> String? {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)

            try await loadUserData()
            
            return nil
        } catch {
            print("DEBUG: Failed to login user with error \(error.localizedDescription)")
            
            return "Invalid login credentials. Please try again."
        }
    }
    
    @MainActor
    func createUser(fullname: String, email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            self.userSession = result.user
            
            try await self.uploadUserData(
                id: result.user.uid,
                email: email, 
                fullname: fullname,
                username: username
            )
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        
        guard let currentUid = userSession?.uid else {
            self.loading = false
            return
        }
        
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)
        self.loading = false
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        userSession = nil
        currentUser = nil
    }
    
    
    @MainActor
    private func uploadUserData(
        id: String,
        email: String,
        fullname: String,
        username: String
    ) async throws {
        let user = User(id: id, fullname: fullname, email: email, username: username)
        self.currentUser = user
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
    }
}
