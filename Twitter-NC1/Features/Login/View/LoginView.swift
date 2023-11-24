//
//  LoginView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 14/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.colorScheme) var theme
    
    @StateObject var viewModel = LoginViewModel()
    
    var disabled : Bool {
        return viewModel.email.isEmpty || viewModel.password.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("To get started, enter your email and password")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.email.isEmpty ? "" : "Email")
                            .font(.callout)
                            .accessibilityHidden(true)
                        
                        
                        TextField("Email", text: $viewModel.email)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .foregroundStyle(.blue)
                            .accessibilityValue(viewModel.email)
                            .accessibilityLabel("Email")
                        
                        Divider()
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.password.isEmpty ? "" : "Password")
                            .font(.callout)
                            .accessibilityHidden(true)
                            
                        
                        SecureField("Password", text: $viewModel.password)
                            .foregroundStyle(.blue)
                            .accessibilityValue(viewModel.password)
                            .accessibilityLabel("Password")
                        
                        Divider()
                    }
                }
                
                Spacer()
                
                VStack {
                    Button {
                        hideKeyboard()
                        Task { try await viewModel.login() }
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
                            Text("Login")
                                .opacity(disabled ? 0.5 : 1)
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(theme == .light ? .black : .white)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .foregroundStyle(theme == .light ? .white : .black)
                                .bold()
                        }
                    }
                    .disabled(disabled)
                    .accessibilityHint("Tap to login. Disabled when fields are empty")
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Register")
                            .padding(.vertical, 10)
                            .bold()
                            .font(.caption)
                    }
                    .accessibilityLabel("Register")
                    .accessibilityHint("Tap to navigate to register view")
                }
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
}

#Preview {
    LoginView()
}
