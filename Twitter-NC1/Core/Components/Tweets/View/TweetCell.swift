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
                        .accessibilityLabel("User profile image of the tweet")
                }
                else {
                    NavigationLink {
                        UserProfileView(user: user)
                    } label: {
                        CircularProfileImageView(user: user, size: .small)
                            .accessibilityLabel("User profile image of the tweet")
                            .accessibilityHint("Tap to navigate to current tweet's user profile")
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("\(user?.fullname ?? "") ")
                            .font(.footnote.bold())
                            .accessibilityLabel("Tweet's user fullname")
                            .accessibilityValue(user?.fullname ?? "")
                        
                        Text("@\(user?.username ?? "")")
                            .font(.footnote)
                            .accessibilityLabel("Tweet's user username")
                            .accessibilityValue(user?.username ?? "")
                        
                        Text(" • \(tweet.timestamp.timestampString())")
                            .font(.footnote)
                            .accessibilityLabel("Tweet's timeago")
                            .accessibilityValue(tweet.timestamp.timestampString())
                        
                        Spacer()
                    }
                    
                    Text(tweet.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .accessibilityLabel("Caption of the tweet")
                        .accessibilityValue(tweet.caption)
                    
                    HStack(spacing: 16) {
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        .accessibilityLabel("Comment tweet")
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.2.squarepath")
                        }
                        .accessibilityLabel("Repost tweet")
                        
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
                        .accessibilityLabel((viewModel.tweet.didLike ?? false) ? "Unlike" : "Like")
                        .accessibilityHint((viewModel.tweet.didLike ?? false) ? "Tap to unlike tweet" : "Tap to like tweet")
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                        }
                        .accessibilityLabel("Save tweet")
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
