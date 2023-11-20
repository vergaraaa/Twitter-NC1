//
//  UserProfileView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import SwiftUI

struct UserProfileView: View {
    
    @Namespace var animation
    @Environment(\.colorScheme) var theme
    
    @State var isPresented: Bool = false
    @State var selectedFilter: ProfileTwitterFilter = .posts
    
    @StateObject var viewModel: ProfileViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: AuthService.shared.currentUser))
    }
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileTwitterFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    var currentUser: User? = AuthService.shared.currentUser
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        CircularProfileImageView(user: currentUser, size: .large)
                        
                        Spacer()
                        
                        Button {
                            isPresented.toggle()
                        } label: {
                            Text("Edit profile")
                                .font(.caption.bold())
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                                .foregroundStyle(theme == .light ? .black : .white)
                        }
                        .cornerRadius(25)
                    }
                    
                    Text(currentUser?.fullname ?? "vergara")
                        .font(.title.bold())
                    
                    Text("@\(currentUser?.username ?? "vergaraaa")")
                        .foregroundStyle(.gray)
                    
                    if let bio = currentUser?.bio {
                        Text(bio)
                            .padding(.top)
                    }
                    
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
                }
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
            .sheet(isPresented: $isPresented) {
                EditProfileView()
            }
        }
    }
}

#Preview {
    UserProfileView()
}
