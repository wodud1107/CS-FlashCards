//
//  LoginViewModel.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import Foundation
import AuthenticationServices
import SwiftUI

class LoginViewModel: NSObject, ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    @Published var nickname: String = ""
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func loginWithEmail(userSession: UserSession) {
        if email == "test@test.com", password == "1234" {
            let user = User(id: Int(), userId: "test", nickname: "", userName: "홍길동", email: "test@test.com", createdAt: Date())
            userSession.user = user
            self.isLoggedIn = true
            
            if let encoded = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(encoded, forKey: "loginUser")
            }
            
            self.errorMessage = nil
            print("✅ 로그인 성공, userSession.user: \(String(describing: userSession.user))")
        } else {
            self.errorMessage = "로그인 정보가 올바르지 않습니다."
            print("❌ 로그인 실패")
        }
    }
    
    func handleAppleSignIn(userSession: UserSession, result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            if let credential = auth.credential as? ASAuthorizationAppleIDCredential {
                let userId = credential.user
                let fullName = credential.fullName?.givenName ?? ""
                let email = credential.email
                let user = User(id: Int(), userId: userId, nickname: "", userName: fullName, email: email, createdAt: Date())
                userSession.user = user
                self.isLoggedIn = true
                
                if let encoded = try? JSONEncoder().encode(user) {
                    UserDefaults.standard.set(encoded, forKey: "loginUser")
                }
                
                self.errorMessage = nil
                print("✅ 로그인 성공, userSession.user: \(String(describing: userSession.user))")
            }
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isLoggedIn = false
            print("❌ 로그인 실패")
        }
    }
    
    func updateNickname(userSession: UserSession, _ nickname: String) {
        self.nickname = nickname
        
        if var user = userSession.user {
            user.nickname = nickname
            userSession.user = user
            print("🟢 닉네임 입력됨: \(nickname)")
        }
    }
    
    func logout(userSession: UserSession) {
        print("🟢 로그아웃됨: \(String(describing: userSession.user?.userId))")
        UserDefaults.standard.removeObject(forKey: userSession.user!.userId)
        userSession.user = nil
        self.isLoggedIn = false
        self.errorMessage = nil
    }
}
