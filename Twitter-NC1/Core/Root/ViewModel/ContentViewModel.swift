//
//  ContentViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 15/11/23.
//

import Combine
import Firebase
import Foundation

class ContentViewModel: ObservableObject {
    private let authService = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var loading: Bool = true
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        authService.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        authService.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
        
        authService.$loading.sink { [weak self] loading in
            self?.loading = loading
        }
        .store(in: &cancellables)
    }
}
