//
//  ContentView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        if loginVM.isLoggedIn {
            FlashCardView(viewModel: FlashCardViewModel())
        } else {
            LoginView(viewModel: loginVM)
        }
    }
}

#Preview {
    ContentView()
}
