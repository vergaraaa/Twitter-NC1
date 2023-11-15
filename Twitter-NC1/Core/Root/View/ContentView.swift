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
        if viewModel.userSession != nil {
            Text("Logged in")
        }
        else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
