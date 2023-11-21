//
//  UserProfileView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    @Environment(\.colorScheme) var theme
    
    @State var isPresented: Bool = false
    
    @StateObject var viewModel = CurrentProfileViewModel()

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        ProfileHeaderView(user: viewModel.currentUser, isPresented: $isPresented)
                            .padding(.horizontal)
                        
                        UserContentListView(user: viewModel.currentUser)
                    }
                    
                }
                .sheet(isPresented: $isPresented) {
                    EditProfileView(user: viewModel.currentUser)
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
