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
    
    @StateObject var viewModel = EditProfileViewModel()
    
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
                    }
                    else {
                        CircularProfileImageView(user: nil, size: .xLarge)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Divider()
                    .padding(.vertical, 2.5)
                
                HStack(spacing: 10) {
                    Text("Name")
                        .bold()
                    
                    Spacer()
                    
                    TextField("Add your name", text: $viewModel.fullname)
                }
                
                Divider()
                    .padding(.vertical, 5)
                
                HStack(spacing: 20) {
                    Text("Bio")
                        .bold()
                    
                    Spacer()
                    
                    TextField("Add your name", text: $viewModel.bio)
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
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
//                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    EditProfileView()
}
