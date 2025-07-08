//
//  FlashCard.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import Foundation
import SQLite

struct FlashCard: Identifiable, Codable {
    let id: Int
    let type: Int
    let front: String
    let back: String
    let known: Bool
}

func getDBPath() -> String? {
    guard let path = Bundle.main.path(forResource: "cards-jwasham", ofType: "db") else {
        print("DB 파일 경로를 찾을 수 없습니다.")
        return nil
    }
    return path
}

class CardDBService {
    private var db: Connection?
    
    init?() {
        guard let path = getDBPath() else { return nil }
        do {
            db = try Connection(path, readonly: true)
        } catch {
            print("DB 연결 실패: \(error)")
            return nil
        }
    }
    
    func fetchCards() -> [FlashCard] {
        var cards: [FlashCard] = []
        guard let db = db else { return cards }
        
        let cardsTable = Table("cards")
        let id = Expression<Int>("id")
        let type = Expression<Int>("type")
        let front = Expression<String>("front")
        let back = Expression<String>("back")
        let known = Expression<Bool>("known")
        
        do {
            for row in try db.prepare(cardsTable) {
                let card = FlashCard(
                    id: row[id],
                    type: row[type],
                    front: row[front],
                    back: row[back],
                    known: row[known]
                )
                cards.append(card)
            }
        } catch {
            print("카드 불러오기 실패: \(error)")
        }
        
        return cards
    }
}
