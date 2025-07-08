//
//  LoginViewModel.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import Foundation
import AuthenticationServices

class LoginViewModel: NSObject, ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    @Published var nickname: String = ""
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func loginWithEmail() {
        if email == "test@test.com", password == "1234" {
            self.user = User(id: Int(), userId: "test", nickname: "Test", userName: "홍길동", email: "test@test.com", createdAt: Date())
            self.isLoggedIn = true
        } else {
            self.errorMessage = "로그인 정보가 올바르지 않습니다."
        }
    }
    
    func handleAppleSignIn(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            if let credential = auth.credential as? ASAuthorizationAppleIDCredential {
                let userId = credential.user
                let fullName = credential.fullName?.givenName ?? ""
                let email = credential.email
                let user = User(id: Int(), userId: userId, nickname: "", userName: fullName, email: email, createdAt: Date())
                self.user = user
                self.isLoggedIn = true
                self.errorMessage = nil
            }
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isLoggedIn = false
        }
    }
    
    func logout() {
        self.user = nil
        self.isLoggedIn = false
        self.errorMessage = nil
    }
    
    func updateNickname(_ nickname: String) {
        self.nickname = nickname
        if var user = self.user {
            user.nickname = nickname
            self.user = user
        }
    }
}
