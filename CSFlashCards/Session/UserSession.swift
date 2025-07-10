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
            let user = try? JSONDecoder().decode(User.self, from: userData)
            if let savedToken = UserDefaults.standard.string(forKey: "loginToken") {
                if savedToken == generateToken(for: user!.userId) {
                    self.user = user
                }
            }
        }
    }
}
