//
//  MainTabView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/9/25.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some View {
        TabView {
            FlashCardView(viewModel: FlashCardViewModel())
                .tabItem { Label("카드", systemImage: "rectangle.on.rectangle") }
            SettingView(loginVM: loginVM)
                .tabItem{ Label("설정", systemImage: "gear") }
        }
    }
}
