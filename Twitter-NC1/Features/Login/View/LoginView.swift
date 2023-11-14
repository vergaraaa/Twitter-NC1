//
//  LoginView.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 14/11/23.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    @Environment(\.colorScheme) var theme
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("To get started, enter your email and password")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(email.isEmpty ? "" : "Email")
                            .font(.callout)
                            
                        
                        TextField("Email", text: $email)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .foregroundStyle(.blue)
                        
                        Divider()
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(password.isEmpty ? "" : "Password")
                            .font(.callout)
                        
                        SecureField("Password", text: $password)
                            .foregroundStyle(.blue)
                        
                        Divider()
                    }
                }
                
                
                Spacer()
                
                VStack {
                    Button {
                        
                    } label: {
                        Text("Login")
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(theme == .light ? .black : .white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .foregroundStyle(theme == .light ? .white : .black)
                            .bold()
                    }
                    
                    Text("Forgot password?")
                        .padding(.vertical, 10)
                        .bold()
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("X")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
