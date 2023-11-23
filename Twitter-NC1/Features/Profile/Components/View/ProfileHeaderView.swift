//
//  ProfileHeader.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User?
    
    @Binding var isPresented: Bool
    
    @Environment(\.colorScheme) var theme
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .xLarge)
            
            Spacer()
            
            Button {
                if (user?.isCurrentUser ?? false) {
                    isPresented.toggle()
                }
            } label: {
                Text((user?.isCurrentUser ?? false) ? "Edit profile" : "Follow")
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
            .accessibilityLabel((user?.isCurrentUser ?? false) ? "Edit profile" : "Follow")
            .accessibilityHint((user?.isCurrentUser ?? false) ? "Tap to edit your profile" : "Tap to follow user")
        }
        
        Text(user?.fullname ?? "")
            .font(.title.bold())
            .accessibilityLabel("User's fullname")
            .accessibilityValue(user?.fullname ?? "")
        
        Text("@\(user?.username ?? "")")
            .foregroundStyle(.gray)
            .accessibilityLabel("User's username")
            .accessibilityValue(user?.username ?? "")
        
        if let bio = user?.bio {
            Text(bio)
                .padding(.top)
                .accessibilityLabel("User's bio")
                .accessibilityValue(user?.bio ?? "")
        }
    }
}

#Preview {
    ProfileHeaderView(
        user: nil, isPresented: .constant(false)
    )
}
