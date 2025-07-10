//
//  UserSession.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/9/25.
//

import Foundation

class UserSession: ObservableObject {
    @Published var user: User?
    
    init() {
        if let userData = UserDefaults.standard.data(forKey: "loginUser") {
            guard let user = try? JSONDecoder().decode(User.self, from: userData) else {
                print("❌ 사용자 정보를 찾을 수 없습니다.")
                fatalError()
            }
            if let savedToken = UserDefaults.standard.string(forKey: user.userId) {
                if savedToken == generateToken(for: user.userId) {
                    self.user = user
                }
            }
        }
    }
}
