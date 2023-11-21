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
    
    static func likeTweet(_ tweet: Tweet) async throws {
        guard let uid = Firebase.Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.tweetId else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        try await Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes + 1])
        try await userLikesRef.document(tweetId).setData([:])
    }
    
    static func unilkeTweet(_ tweet: Tweet) async throws {
        guard let uid = Firebase.Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.tweetId else { return }
        guard tweet.likes > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        try await Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes - 1])
        try await userLikesRef.document(tweetId).delete()
    }
    
    static func checkIfUserLikesTweet(_ tweet: Tweet) async throws -> Bool {
        guard let uid = Firebase.Auth.auth().currentUser?.uid else { return false }
        guard let tweetId = tweet.tweetId else { return false }
        
        let snapshot = try await Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId)
            .getDocument()
        
        return snapshot.exists
    }
    
    static func fetchLikeTweets(forUid uid: String) async throws -> [Tweet] {
        var tweets = [Tweet]()
        
        let snapshot = try await Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments()
        
        let documents = snapshot.documents
        
        for doc in documents {
            let tweetDoc = try await Firestore.firestore().collection("tweets").document(doc.documentID).getDocument()
            
            guard let tweet = try? tweetDoc.data(as: Tweet.self) else { return [] }
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}
