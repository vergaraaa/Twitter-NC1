//
//  RegisterView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 14/11/23.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.colorScheme) var theme
    
    @StateObject var viewModel = RegisterViewModel()
    
    var disabled : Bool {
        return viewModel.email.isEmpty || viewModel.password.isEmpty ||
        viewModel.fullname.isEmpty || viewModel.username.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create your account")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.fullname.isEmpty ? "" : "Name")
                        .font(.callout)
                        .accessibilityHidden(true)
                    
                    
                    TextField("Name", text: $viewModel.fullname)
                        .autocorrectionDisabled()
                        .foregroundStyle(.blue)
                        .accessibilityValue(viewModel.fullname)
                        .accessibilityLabel("Name textfield")
                    
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.username.isEmpty ? "" : "Username")
                        .font(.callout)
                        .accessibilityHidden(true)
                    
                    TextField("Username", text: $viewModel.username)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.blue)
                        .accessibilityValue(viewModel.username)
                        .accessibilityLabel("Username textfield")
                    
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.email.isEmpty ? "" : "Email")
                        .font(.callout)
                        .accessibilityHidden(true)
                    
                    TextField("Email", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.blue)
                        .accessibilityValue(viewModel.email)
                        .accessibilityLabel("Email textfield")
                    
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.password.isEmpty ? "" : "Password")
                        .font(.callout)
                        .accessibilityHidden(true)
                    
                    SecureField("Password", text: $viewModel.password)
                        .foregroundStyle(.blue)
                        .accessibilityValue(viewModel.password)
                        .accessibilityLabel("Password textfield")
                    
                    Divider()
                }
            }
            
            Spacer()
            
            Button {
                hideKeyboard()
                Task { try await viewModel.register() }
            } label: {
                if viewModel.loading {
                    ProgressView()
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(theme == .light ? .black : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .tint(theme == .light ? .white : .black)
                }
                else {
                    Text("Register")
                        .opacity(disabled ? 0.5 : 1)
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(theme == .light ? .black : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .foregroundStyle(theme == .light ? .white : .black)
                        .bold()
                        .accessibilityHint("Tap to Register. Disabled when fields are empty")
                }
            }
            .padding(.bottom)
            .disabled(disabled)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HeaderLogo()
            }
        }
        .alert(viewModel.error ?? "", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {
                viewModel.showAlert = false
            }
        }
    }
}

#Preview {
    RegisterView()
}
