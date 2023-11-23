//
//  EditProfile.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 17/11/23.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User?) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .accessibilityLabel("New profile image to be uploaded")
                    }
                    else {
                        CircularProfileImageView(user: viewModel.user, size: .xLarge)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .accessibilityHint("Tap to update your profile image")
                
                Divider()
                    .padding(.vertical, 2.5)
                
                HStack(spacing: 10) {
                    Text("Name")
                        .bold()
                    
                    Spacer()
                    
                    TextField("Add your name", text: $viewModel.fullname)
                        .accessibilityLabel("Name textfield")
                        .accessibilityValue(viewModel.fullname)
                        .accessibilityHint("Tap to edit your fullname")
                }
                
                Divider()
                    .padding(.vertical, 5)
                
                HStack(spacing: 20) {
                    Text("Bio")
                        .bold()
                    
                    Spacer()
                    
                    TextField("Add your bio", text: $viewModel.bio)
                        .accessibilityLabel("Bio textfield")
                        .accessibilityValue(viewModel.bio)
                        .accessibilityHint("Tap to edit your bio")
                }
                
                Divider()
                    .padding(.vertical, 2.5)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .accessibilityHint("Tap to dismiss modal")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            try await viewModel.updateUser()
                            dismiss()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .accessibilityHint("Tap to update your information")
                }
            }
        }
    }
}

#Preview {
    EditProfileView(user: nil)
}
