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
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var verificationCode: String = ""
    @State var step: LoginState = .login
    @State var animateGradient = false
    @State var error: String?
    
    var buttonTitle: String {
        switch step {
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
                
                if step == .login || step == .registerUser {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                    if step == .registerUser {
                        SecureField("Confirm Password", text: $confirmPassword)
                    }
                } else if step == .verificationPending {
                    TextField("Verification Code", text: $verificationCode)
                }
                
                TaskButton(action: onPressButton) {
                        Text(buttonTitle).frame(maxWidth: .infinity)
                }
                .padding(.top, 8)
                
                if step == .login || step == .registerUser {
                    let registerUser = step == .registerUser
                    HStack {
                        Text(registerUser ? "Already have an account?" : "Don't have an account?").font(.callout)
                        Button(registerUser ? "Log In" :  "Sign Up") {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                step = registerUser ? .login : .registerUser
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
            .alert(isPresented: Binding(get: {error != nil}, set: { if !$0 { error = nil } })) {
                Alert(title: Text(error!))
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
        }
    }
    
    func onPressButton() async {
        switch step {
        case .login:
            await viewModel.signIn(email: email, password: password)
        case .registerUser:
            await viewModel.signUp(
                email: email,
                password: password,
                onVerificationPending: { step = .verificationPending }
            )
        case .verificationPending:
            await viewModel.verifySignUp(email: email, verificationCode: verificationCode)
        }
    }
    
    var validateCredentials: Bool {
        // TODO: validate email
        switch step {
        case .registerUser:
            return password == confirmPassword && !email.isEmpty && password.count > 6 && !password.contains(" ")
        case .login:
            return !email.isEmpty && password.count > 6 && !password.contains(" ")
        case .verificationPending:
            return !verificationCode.isEmpty && !verificationCode.contains(" ")
        }
    }
 
}

#Preview {
    LoginScreen()
}
