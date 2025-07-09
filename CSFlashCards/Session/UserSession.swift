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
        let userId = "test"
        if let savedToken = UserDefaults.standard.string(forKey: userId) {
            if savedToken == generateToken(for: userId) {
                self.user = User(
                    id: 1,
                    userId: userId,
                    nickname: "Test",
                    userName: "홍길동",
                    email: "test@test.com",
                    createdAt: Date()
                )
            }
        }
    }
}
