//
//  FeedView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 16/11/23.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0 ..< 20) { tweet in
                        TweetCell(tweet: Tweet.MOCK_TWEET)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HeaderLogo()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FeedView()
}
