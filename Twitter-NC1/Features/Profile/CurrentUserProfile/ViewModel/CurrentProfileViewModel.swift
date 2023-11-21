//
//  ProfileViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 20/11/23.
//

import Combine
import Firebase
import Foundation

class CurrentProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        AuthService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
