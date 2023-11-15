//
//  RegisterViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 14/11/23.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var loading = false
    @Published var error : String?
    @Published var showAlert = false
    
    @MainActor
    func register() async throws {
        loading = true
        
        error = try await AuthService.shared.createUser(
            fullname: fullname,
            email: email,
            password: password,
            username: username
        )
        
        loading = false
        
        if error != nil {
            showAlert = true
        }
    }
}
