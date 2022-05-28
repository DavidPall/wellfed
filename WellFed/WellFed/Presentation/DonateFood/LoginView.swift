//
//  LoginView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: UIImage(named: "brandIcon") ?? UIImage())
                .resizable()
                .scaledToFit()
                .padding()
                .padding()
            Spacer()
            VStack {
                TextField("Username", text: .constant(""))
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.gray.opacity(0.2))
                    }
                    .padding([.horizontal, .top])
                SecureField("Password", text: .constant(""))
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.gray.opacity(0.2))
                    }
                    .padding()
                HStack {
                    Spacer()
                    Button("Account Recovery", action: {})
                }.padding(.horizontal)
            }.padding()
            Spacer()
            Button {
                loggedIn.toggle()
            } label: {
                Text("Login")
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.gray.opacity(0.2))
                    }
                    .padding()
            }
            Spacer()
            HStack {
                Text("Not a member?")
                Button("Register now", action: {})
            }
            NavigationLink("Terms and Conditions", destination: {})
                .foregroundColor(.projectBlue).padding()
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loggedIn: .constant(false))
    }
}
