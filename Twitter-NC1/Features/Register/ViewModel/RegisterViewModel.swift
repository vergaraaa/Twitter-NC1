//
//  RegisterViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 14/11/23.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
}
