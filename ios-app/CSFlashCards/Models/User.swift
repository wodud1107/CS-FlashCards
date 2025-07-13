//
//  User.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int
    let userId: String
    var nickname: String
    let userName: String?
    let email: String?
    let createdAt: Date
}

struct LoginResponse: Codable {
    let success: Bool
    let user: User?
    let error: String?
}

import CryptoKit

func generateToken(for userId: String) -> String {
    let data = Data(userId.utf8)
    let hash = SHA256.hash(data: data)
    return hash.compactMap { String(format: "%02x", $0) }.joined()
}
