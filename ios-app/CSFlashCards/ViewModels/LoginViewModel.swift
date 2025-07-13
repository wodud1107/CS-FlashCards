//
//  LoginViewModel.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import Foundation
import AuthenticationServices
import SwiftUI
import SwiftKeychainWrapper

class LoginViewModel: NSObject, ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    @Published var nickname: String = ""
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func handleAppleSignIn(credential: ASAuthorizationAppleIDCredential, userSession: UserSession) {
        let userId = credential.user
        let email = credential.email
        let userName = credential.fullName?.givenName

        APISession.shared.appleSignIn(userId: userId, email: email, userName: userName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let res):
                    userSession.user = res.user
                    self?.isLoggedIn = true
                    self?.errorMessage = nil
                    
                    // 토큰 저장
                    KeychainWrapper.standard.set(res.token, forKey: "jwtToken")
                case .failure(let error):
                    self?.isLoggedIn = false
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func updateNickname(userSession: UserSession) {
        guard let userId = userSession.user?.userId else { return }
        
        APISession.shared.updateNickname(userId: userId, nickname: nickname) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedUser):
                    userSession.user = updatedUser
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func logout(userSession: UserSession) {
        print("🟢 로그아웃됨: \(String(describing: userSession.user?.userId))")
        KeychainWrapper.standard.removeObject(forKey: "jwtToken")
        userSession.user = nil
        self.isLoggedIn = false
        self.errorMessage = nil
    }
}
