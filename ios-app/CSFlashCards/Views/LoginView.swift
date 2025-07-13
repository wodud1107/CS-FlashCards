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
    @State private var showNicknameSheet = false
    
    var body: some View {
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
                    switch result {
                    case .success(let authResults):
                        if let credential = authResults.credential as? ASAuthorizationAppleIDCredential {
                            viewModel.handleAppleSignIn(credential: credential, userSession: userSession)
                        }
                    case .failure(let error):
                        viewModel.errorMessage = error.localizedDescription
                    }
                }
            )
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .cornerRadius(10)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
        }
        .padding()
        .onChange(of: userSession.user) { newUser in
            print("🟢 onChange userSession.user fired! newUser: \(String(describing: newUser))")
            if let user = newUser, user.nickname.isEmpty {
                print("🔵 닉네임 비어있음, 모달 띄움")
                showNicknameSheet = true
            }
        }
        .sheet(isPresented: $showNicknameSheet) {
            VStack(spacing: 16) {
                Text("닉네임을 입력하세요")
                TextField("닉네임", text: $viewModel.nickname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("저장") {
                    viewModel.updateNickname(userSession: userSession)
                    showNicknameSheet = false
                }
                .disabled(viewModel.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding()
            .presentationDetents([.fraction(0.3)])
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
        }
    }
}
