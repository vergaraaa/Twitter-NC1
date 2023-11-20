//
//  TweetCell.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 16/11/23.
//

import SwiftUI
import FirebaseFirestore

struct TweetCell: View {
    
    let tweet: Tweet
    var user: User? { tweet.user }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                CircularProfileImageView(user: tweet.user, size: .small)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(user?.fullname ?? "") ")
                            .font(.footnote.bold())
                        +
                        Text("@\(user?.username ?? "") • \(tweet.timestamp.timestampString())")
                            .font(.footnote)
                    }
                    
                    Text(tweet.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16) {
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                        }
                    }
                    .padding(.top, 1)
                    .padding(.bottom, 5)
                    .font(.footnote)
                }
            }
            
            Divider()
        }
        .padding(.horizontal)
    }
}

#Preview {
    TweetCell(tweet: Tweet.MOCK_TWEET)
}
