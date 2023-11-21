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
    
    @StateObject var viewModel: TweetCellViewModel
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self._viewModel = StateObject(wrappedValue: TweetCellViewModel(tweet: tweet))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                
                if(user?.isCurrentUser ?? false) {
                    CircularProfileImageView(user: user, size: .small)
                }
                else {
                    NavigationLink {
                        UserProfileView(user: user)
                    } label: {
                        CircularProfileImageView(user: user, size: .small)
                    }
                }
                
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
                            Image(systemName: "arrow.2.squarepath")
                        }
                        
                        Spacer()
                        
                        Button {
                            Task {
                                if viewModel.tweet.didLike ?? false {
                                    try await viewModel.unlikeTweet()
                                }
                                else {
                                    try await viewModel.likeTweet()
                                }
                            }
                        } label: {
                            Image(systemName: (viewModel.tweet.didLike ?? false) ? "heart.fill" : "heart")
                                .foregroundStyle((viewModel.tweet.didLike ?? false)  ? .pink : .blue)
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
