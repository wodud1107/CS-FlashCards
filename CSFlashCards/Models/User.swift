//
//  User.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import Foundation

struct User: Codable {
    let id: UUID
    let userId: String
    var nickname: String
    let userName: String?
    let email: String?
    let createdAt: Date
}
