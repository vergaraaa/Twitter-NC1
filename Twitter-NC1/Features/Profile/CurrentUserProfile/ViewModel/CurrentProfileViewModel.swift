//
//  ProfileViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 20/11/23.
//

import Firebase
import Foundation

class CurrentProfileViewModel: ObservableObject {
    @Published var user: User?
    
    init() {
        self.user = AuthService.shared.currentUser
    }
}
