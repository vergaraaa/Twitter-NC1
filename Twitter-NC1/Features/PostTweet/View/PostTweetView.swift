//
//  PostTweetView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import SwiftUI

struct PostTweetView: View {
    @StateObject var viewModel = PostTweetViewModel()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var theme
    
    var disabled: Bool {
        viewModel.caption.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView(user: AuthService.shared.currentUser, size: .small)
                    
                    TextField("What's happening today?", text: $viewModel.caption, axis: .vertical)
                        .multilineTextAlignment(.leading)
                        .accessibilityLabel("Caption textfield")
                        .accessibilityValue(viewModel.caption)
                }
                .padding()
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .disabled(viewModel.loading)
                    .foregroundStyle(theme == .light ? .black : .white)
                    .accessibilityLabel("Cancel")
                    .opacity(viewModel.loading ? 0.5 : 1)
                    .accessibilityHint("Tap to cancel and dismiss")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            try await viewModel.postTweet()
                            dismiss()
                        }
                    } label: {
                        if viewModel.loading {
                            ProgressView()
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .foregroundStyle(.white)
                                .tint(.white)
                        }
                        else {
                            Text("Post")
                                .bold()
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .foregroundStyle(.white)
                                .opacity(disabled ? 0.5 : 1)
                        }
                    }
                    .disabled(disabled)
                    .accessibilityLabel("Post")
                    .accessibilityHint("Tap to post new tweet. Disabled if Caption TextField is empty")
                }
            }
        }
    }
}

#Preview {
    PostTweetView()
}
