//
//  EditProfileViewModel.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import SwiftUI
import PhotosUI

class EditProfileViewModel: ObservableObject {
    let user: User?
    @Published var loading = false
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task { await loadImage() }
        }
    }
    
    init(user: User?) {
        self.user = user
        
        fullname = user?.fullname ?? ""
        bio = user?.bio ?? ""
    }
    
    @Published var profileImage: Image?
    private var uiImage: UIImage?
    
    @Published var fullname = ""
    @Published var bio = ""
    
    @MainActor
    func updateUser() async throws {
        loading = true
        
        if profileImage != nil {
            try await updateProfileImage()
        }
        
        var newData: [String: String] = [:]
        
        if(user?.fullname != fullname) {
            newData["fullname"] = fullname
        }
        
        if(user?.bio != bio) {
            newData["bio"] = bio
        }
        
        if !newData.isEmpty {
            try await updateUserData(newData: newData)
        }
        
        loading = false
    }
    
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    @MainActor
    private func updateUserData(newData: [String : String]) async throws {
        try await UserService.updateUserData(newData: newData)
        
        if let fullname = newData["fullname"] {
            AuthService.shared.currentUser?.fullname = fullname
        }
        
        if let bio = newData["bio"] {
            AuthService.shared.currentUser?.bio = bio
        }
    }
    
    @MainActor
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try await ImageUploader.uploadImage(image) else { return }
        
        try await UserService.updateUserProfileImage(withImageUrl: imageUrl)
        
        AuthService.shared.currentUser?.profileImageUrl = imageUrl
    }
}
