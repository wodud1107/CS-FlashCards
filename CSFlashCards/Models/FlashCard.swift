//
//  FlashCard.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import Foundation

struct FlashCard: Identifiable, Codable {
    let id: UUID
    let question: String
    let answer: String
    let category: String
    let level: Int
}
