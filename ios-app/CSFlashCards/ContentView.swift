//
//  ContentView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import SwiftUI
import SwiftKeychainWrapper

struct ContentView: View {
    @EnvironmentObject var userSession: UserSession
    @StateObject private var loginVM = LoginViewModel()
    @State private var isCheckingToken = true
    
    var body: some View {
        Group{
            if isCheckingToken {
                ProgressView("자동 로그인 확인 중 ...")
            } else if let user = userSession.user, !user.nickname.isEmpty {
                MainTabView()
            } else {
                LoginView(viewModel: loginVM)
            }
        }
        .onAppear {
            autoLogin()
        }
    }
    
    func autoLogin() {
            guard let jwtToken = KeychainWrapper.standard.string(forKey: "jwtToken") else {
                isCheckingToken = false
                return
            }
            APISession.shared.fetchInfo() { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        userSession.user = user
                    case .failure:
                        // 만료/실패 시 토큰 삭제 및 로그인 화면
                        KeychainWrapper.standard.removeObject(forKey: "jwtToken")
                        userSession.user = nil
                    }
                    isCheckingToken = false
                }
            }
        }
}
