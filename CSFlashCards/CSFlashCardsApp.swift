//
//  CSFlashCardsApp.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import SwiftUI

@main
struct CSFlashCardsApp: App {
    @StateObject var userSession = UserSession()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userSession)
        }
    }
}
