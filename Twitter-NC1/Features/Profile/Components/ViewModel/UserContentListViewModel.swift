//
//  UserContentListViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 21/11/23.
//

import Foundation

class UserContentListViewModel: ObservableObject {
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
        
        for i in 0 ..< tweets.count {
            tweets[i].user = user
        }
        
        self.userTweets = tweets
    }
    
    @MainActor
    func fetchLikeTweets() async throws {
        guard let uid = user?.id else { return }
        
        var tweets = try await TweetsService.fetchLikeTweets(forUid: uid)
        
        for i in 0 ..< tweets.count {
            let uid = tweets[i].ownerUid
            
            tweets[i].user = try await UserService.fetchUser(withUid: uid)
        }
        
        self.userLikes = tweets
    }
}
