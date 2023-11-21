//
//  UserContentListView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 21/11/23.
//

import SwiftUI

struct UserContentListView: View {
    @Namespace var animation
    @State var selectedFilter: ProfileTwitterFilter = .posts
    
    @StateObject var viewModel: UserContentListViewModel
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileTwitterFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    init(user: User?) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(ProfileTwitterFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: filterBarWidth, height: 2)
                                .matchedGeometryEffect(id: "item", in: animation)
                        }
                        else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 2)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            .padding(.top)
            .padding(.horizontal)
            
            if selectedFilter == .posts {
                if viewModel.userTweets.isEmpty {
                    Text("No tweets to show")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                else {
                    LazyVStack {
                        ForEach(viewModel.userTweets) { tweet in
                            TweetCell(tweet: tweet)
                        }
                    }
                }
            }
            else {
                if viewModel.userLikes.isEmpty {
                    Text("No tweets to show")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                else {
                    LazyVStack {
                        ForEach(viewModel.userLikes) { tweet in
                            TweetCell(tweet: tweet)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    UserContentListView(user: nil)
}
