//
//  ContentView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        if viewModel.loading {
            Text("X")
                .font(.largeTitle.bold())
        }
        else {
            if viewModel.currentUser != nil {
                MainTabView()
            }
            else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
