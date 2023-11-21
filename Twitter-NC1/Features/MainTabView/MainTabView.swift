//
//  MainTabView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 16/11/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("", systemImage: "house")
                }
                .tag(0)
            
            CurrentUserProfileView()
                .tabItem {
                    Label("", systemImage: "person")
                }
                .tag(1)
        }
    }
}

#Preview {
    MainTabView()
}
