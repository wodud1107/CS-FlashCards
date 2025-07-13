//
//  LoginResponse.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/13/25.
//

struct LoginResponse: Codable {
    let success: Bool
    let user: User?
    let token: String
    let error: String?
}
