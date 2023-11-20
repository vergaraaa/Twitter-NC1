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
    @Published var userLikes = [Tweet]()
    
    @MainActor
    init(user: User?) {
        self.user = user
        
        Task {
            try await fetchUserTweets()
            try await fetchLikeTweets()
        }
    }
    
    @MainActor
    func fetchUserTweets() async throws {        
        guard let uid = user?.id else { return }
        
        var tweets = try await TweetsService.fetchUserTweets(uid: uid)
        
        for i in 0 ..< userTweets.count {
            tweets[i].user = user
        }
        
        self.userTweets = tweets
    }
    
    @MainActor
    func fetchLikeTweets() async throws {
        guard let uid = user?.id else { return }
        
        var tweets = try await TweetsService.fetchLikeTweets(forUid: uid)
        
        for i in 0 ..< userLikes.count {
            let uid = userLikes[i].ownerUid
            
            tweets[i].user = try await UserService.fetchUser(withUid: uid)
        }
        print(tweets)
        self.userLikes = tweets
    }
}
