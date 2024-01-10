//
//  LoginScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

enum LoginState {
    case login
    case registerUser
    case verificationPending
}

struct LoginScreen: View {
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    
    @State var animateGradient = false
    
    var buttonTitle: String {
        switch viewModel.step {
        case .login:
            return "Login"
        case .registerUser:
            return "Register"
        case .verificationPending:
            return "Verify"
        }
    }
    
    var body: some View {
        NavigationView {
            let gradient = LinearGradient(
                colors: [.red, .red, .clear, .blue, .blue],
                startPoint: animateGradient ? .bottom : .topLeading,
                endPoint: animateGradient ? .topTrailing : .bottom
            ).ignoresSafeArea()
            
            VStack(spacing: 8) {
                Spacer()
                gradient.mask {  VStack {
                    Image("app-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                    Text("NearWonders").font(.largeTitle)
                    Text("Unleash the Hidden Gems of Adventure")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black.opacity(0.8))
                } }
                
                Spacer()
                
                if viewModel.step == .login || viewModel.step == .registerUser {
                    TextField("Email", text: $viewModel.email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                    if viewModel.step == .registerUser {
                        SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    }
                } else if viewModel.step == .verificationPending {
                    TextField("Verification Code", text: $viewModel.verificationCode)
                }
                
                TaskButton(action: onPressButton) {
                        Text(buttonTitle).frame(maxWidth: .infinity)
                }
                .disabled(!viewModel.validateCredentials)
                .padding(.top, 8)
                
                if viewModel.step == .login || viewModel.step == .registerUser {
                    let registerUser = viewModel.step == .registerUser
                    HStack {
                        Text(registerUser ? "Already have an account?" : "Don't have an account?").font(.callout)
                        Button(registerUser ? "Log In" :  "Sign Up") {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.step = registerUser ? .login : .registerUser
                            }
                        }
                    }
                }
                Spacer()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .textFieldStyle(.roundedBorder)
            .font(.headline)
            .background(.thinMaterial)
            .background(gradient)
            .alert(isPresented: Binding(
                get: {viewModel.errorTitle != nil},
                set: { if !$0 {
                    viewModel.errorTitle = nil
                    viewModel.errorMessage = nil
                } })
            ) {
                Alert(
                    title: Text(viewModel.errorTitle!),
                    message: viewModel.errorMessage != nil ? Text(viewModel.errorMessage!) : nil
                )
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
        }
    }
    
    func onPressButton() async {
        switch viewModel.step {
        case .login:
            await viewModel.signIn()
        case .registerUser:
            await viewModel.signUp()
        case .verificationPending:
            await viewModel.verifySignUp()
        }
    }
 
}

#Preview {
    LoginScreen()
}
