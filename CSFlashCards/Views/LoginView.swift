//
//  LoginView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("이메일", text: $viewModel.email)
            SecureField("비밀번호", text: $viewModel.password)
            Button("로그인") {
                viewModel.loginWithEmail(userSession: userSession)
            }
        }
        .padding()
        VStack(spacing: 32) {
            Text("CS FlashCards")
                .font(.largeTitle)
                .bold()
            
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    viewModel.handleAppleSignIn(userSession: userSession, result: result)
                },
            )
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .cornerRadius(10)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
            
            if let user = viewModel.user {
                if user.nickname.isEmpty {
                    VStack {
                        Text("이름을 정해주세요.")
                        TextField("이름", text: $viewModel.nickname)
                        Button("저장") {
                            viewModel.updateNickname(viewModel.nickname)
                        }
                    }
                }
                Text("환영합니다, \(user.nickname) 님!")
            }
        }
        .padding()
    }
}
