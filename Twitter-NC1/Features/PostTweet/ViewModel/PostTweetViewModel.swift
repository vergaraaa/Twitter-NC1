//
//  PostTweetViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import Firebase
import Foundation
import FirebaseFirestore

class PostTweetViewModel: ObservableObject {
    @Published var caption = ""
    @Published var loading = false
    
    let currentUser = AuthService.shared.currentUser
    
    @MainActor
    func postTweet() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let tweet = Tweet(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0)
        
        loading = true
        try await TweetsService.uploadTweet(tweet)
        loading = false
    }
}
