//
//  UserProfileView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 21/11/23.
//

import SwiftUI

struct UserProfileView: View {
    let user: User?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ProfileHeaderView(
                    user: user,
                    isPresented: .constant(false)
                )
                .padding(.horizontal)
                
                UserContentListView(user: user)
            }
        }
    }
}

#Preview {
    UserProfileView(user: nil)
}
