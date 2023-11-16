//
//  Tweet.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 16/11/23.
//

import Firebase
import Foundation
import FirebaseFirestore

struct Tweet: Identifiable, Codable {
    @DocumentID var tweetId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    
    var id: String {
        return tweetId ?? NSUUID().uuidString
    }
    
    var user: User?
}

extension Tweet {
    static let MOCK_TWEET = Tweet(ownerUid: "", caption: "this is a tweet caption", timestamp: Timestamp(), likes: 0)
}
