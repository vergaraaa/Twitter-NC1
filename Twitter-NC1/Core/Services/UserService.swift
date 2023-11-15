//
//  UserService.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 15/11/23.
//

import Firebase
import Foundation
import FirebaseFirestore

struct UserService {
    static func fetchAllUser() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
}

