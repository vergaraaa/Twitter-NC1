//
//  ProfileViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 20/11/23.
//

import Firebase
import Foundation

class ProfileViewModel: ObservableObject {
    let user: User?
    
    @Published var userTweets = [Tweet]()
    @Published var loading = true
    
    @MainActor
    init(user: User?) {
        self.user = user
        
        Task {
            try await fetchUserTweets()
            loading = false
        }
    }
    
    @MainActor
    func fetchUserTweets() async throws {        
        guard let uid = user?.id else { return }
        userTweets = try await TweetsService.fetchUserTweets(uid: uid)
        
        for i in 0 ..< userTweets.count {
            self.userTweets[i].user = user
        }
    }
}
