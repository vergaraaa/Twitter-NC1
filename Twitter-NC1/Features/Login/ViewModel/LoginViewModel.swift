//
//  LoginViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 14/11/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var loading = false
    @Published var error : String?
    @Published var showAlert = false
    
    @MainActor
    func login() async throws {
        loading = true
        
        error = try await AuthService.shared.login(
            withEmail: email,
            password: password
        )
        
        loading = false
        
        if error != nil {
            showAlert = true
        }
    }
}
