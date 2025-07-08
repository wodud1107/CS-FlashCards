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
    
    init() {
        if let dbService = CardDBService() {
            self.cards = dbService.fetchCards()
        }
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
