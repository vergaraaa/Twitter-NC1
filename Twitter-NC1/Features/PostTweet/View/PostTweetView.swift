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
                    CircularProfileImageView(user: nil, size: .small)
                    
                    TextField("What's happening today?", text: $viewModel.caption, axis: .vertical)
                        .multilineTextAlignment(.leading)
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
                    .foregroundStyle(theme == .light ? .black : .white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Post")
                            .bold()
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .foregroundStyle(.white)
                            .opacity(disabled ? 0.5 : 1)
                    }
                    .disabled(disabled)
                }
            }
        }
    }
}

#Preview {
    PostTweetView()
}
