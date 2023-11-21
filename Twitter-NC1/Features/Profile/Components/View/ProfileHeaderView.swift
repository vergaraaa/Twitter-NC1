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
            CircularProfileImageView(user: user, size: .large)
            
            Spacer()
            
            Button {
                if (user?.isCurrentUser ?? false) {
                    isPresented.toggle()
                }
                else {
                    
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
        }
        
        Text(user?.fullname ?? "")
            .font(.title.bold())
        
        Text("@\(user?.username ?? "")")
            .foregroundStyle(.gray)
        
        if let bio = user?.bio {
            Text(bio)
                .padding(.top)
        }
    }
}

#Preview {
    ProfileHeaderView(
        user: nil, isPresented: .constant(false)
    )
}
