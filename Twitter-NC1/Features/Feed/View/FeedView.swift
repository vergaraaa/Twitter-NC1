//
//  FeedView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 16/11/23.
//

import SwiftUI

struct FeedView: View {
    
    @State var isPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(0 ..< 20) { tweet in
                            TweetCell(tweet: Tweet.MOCK_TWEET)
                        }
                    }
                }
                
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(.blue)
                        .clipShape(Circle())
                        .foregroundStyle(.white)
                }
                .padding()
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
            .fullScreenCover(isPresented: $isPresented) {
                PostTweetView()
            }
        }
    }
}

#Preview {
    FeedView()
}
