//
//  FeedView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 16/11/23.
//

import SwiftUI

struct FeedView: View {
    
    @State var isPresented = false
    
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                if viewModel.loading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(viewModel.tweets) { tweet in
                                TweetCell(tweet: tweet)
                            }
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
            .refreshable {
                Task { try await viewModel.fetchTweets() }
            }
        }
    }
}

#Preview {
    FeedView()
}
