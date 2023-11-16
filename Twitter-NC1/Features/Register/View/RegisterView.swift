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
            Text("Register")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.fullname.isEmpty ? "" : "Name")
                        .font(.callout)
                    
                    
                    TextField("Name", text: $viewModel.fullname)
                        .autocorrectionDisabled()
                        .foregroundStyle(.blue)
                    
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.username.isEmpty ? "" : "Username")
                        .font(.callout)
                    
                    
                    TextField("Username", text: $viewModel.username)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.blue)
                    
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.email.isEmpty ? "" : "Email")
                        .font(.callout)
                    
                    
                    TextField("Email", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.blue)
                    
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.password.isEmpty ? "" : "Password")
                        .font(.callout)
                    
                    SecureField("Password", text: $viewModel.password)
                        .foregroundStyle(.blue)
                    
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
