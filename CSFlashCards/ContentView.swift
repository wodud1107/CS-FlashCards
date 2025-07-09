//
//  ContentView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userSession: UserSession
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        if userSession.user == nil {
            LoginView(viewModel: loginVM)
        } else {
            MainTabView()
        }
    }
}
