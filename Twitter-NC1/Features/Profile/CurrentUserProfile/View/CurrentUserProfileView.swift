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
                        ProfileHeaderView(user: viewModel.user, isPresented: $isPresented)
                            .padding(.horizontal)
                        
                        UserContentListView(user: viewModel.user)
                    }
                    
                }
                .sheet(isPresented: $isPresented) {
                    EditProfileView()
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
