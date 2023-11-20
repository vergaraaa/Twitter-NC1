//
//  FeedViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 16/11/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    @Published var loading = true
    
    @MainActor
    init() {
        Task {
            try await fetchTweets()
            loading = false
        }
    }
    
    @MainActor
    func fetchTweets() async throws {
        tweets = try await TweetsService.fetchTweets()
    }
}
