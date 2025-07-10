//
//  MainTabView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/9/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var loginVM = LoginViewModel()
    @State private var showWelcome = true
    
    var body: some View {
        ZStack {
            TabView {
                FlashCardView(viewModel: FlashCardViewModel())
                    .tabItem { Label("카드", systemImage: "rectangle.on.rectangle") }
                SettingView(loginVM: loginVM)
                    .tabItem{ Label("설정", systemImage: "gear") }
            }
            if showWelcome {
                VStack {
                    Spacer()
                    Text("\(userSession.user?.nickname ?? "")님, 환영합니다! 👋")
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(radius: 3)
                            .padding(.bottom, 80)
                }
                .transition(.move(edge: .bottom))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        withAnimation { showWelcome = false }
                    }
                }
            }
        }
    }
}
