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
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { userSession in
            self.userSession = userSession
        }
        .store(in: &cancellables)
    }
}
