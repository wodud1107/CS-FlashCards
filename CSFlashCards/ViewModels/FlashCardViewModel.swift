//
//  FlashCardViewModel.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import Foundation

class FlashCardViewModel: ObservableObject {
    @Published var cards: [FlashCard] = []
    @Published var currentIndex: Int = 0
    
    // 추후 db 업데이트
    init() {
        cards = [
            FlashCard(id: UUID(), question: "What is a stack?", answer: "LIFO data structure", category: "Data Structure", level: 0),
            FlashCard(id: UUID(), question: "Big-O asymptotic notation of binary search is?", answer: "O(log N)", category: "Algorithm", level: 0),
        ]
    }
    
    var currentCard: FlashCard? {
        guard !cards.isEmpty, currentIndex < cards.count else { return nil }
        return cards[currentIndex]
    }
    
    func nextCard() {
        if currentIndex < cards.count - 1 {
            currentIndex += 1
        }
    }
    
    func prevCard() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}
