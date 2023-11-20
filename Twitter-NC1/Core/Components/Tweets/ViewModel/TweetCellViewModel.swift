//
//  TweetCellViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 20/11/23.
//

import Foundation

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
        
        Task {
            try await checkIfUserLikesTweet()
        }
    }
    
    @MainActor
    func likeTweet() async throws {
        try await TweetsService.likeTweet(tweet)
        tweet.didLike = true
        tweet.likes = tweet.likes + 1 
    }
    
    @MainActor
    func unlikeTweet() async throws {
        try await TweetsService.unilkeTweet(tweet)
        tweet.didLike = false
        tweet.likes = tweet.likes - 1
    }
    
    @MainActor
    func checkIfUserLikesTweet() async throws {
        if try await TweetsService.checkIfUserLikesTweet(tweet) {
            tweet.didLike = true
        }
    }
}
