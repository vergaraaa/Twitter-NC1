//
//  TweetsService.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 19/11/23.
//

import Firebase
import Foundation
import FirebaseFirestore

struct TweetsService {
    static func uploadTweet(_ tweet: Tweet) async throws {
        guard let tweetData = try? Firestore.Encoder().encode(tweet) else { return }
        try await Firestore.firestore().collection("tweets").addDocument(data: tweetData)
    }
    
    static func fetchTweets() async throws -> [Tweet] {
        let snapshot = try await Firestore
            .firestore()
            .collection("tweets")
            .order(by: "timestamp", descending: true).getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Tweet.self) })
    }
    
    static func fetchUserTweets(uid: String) async throws -> [Tweet] {
        let snapshot = try await Firestore
            .firestore()
            .collection("tweets")
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        let tweets = snapshot.documents.compactMap({ try? $0.data(as: Tweet.self) })
        
        return tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
}
