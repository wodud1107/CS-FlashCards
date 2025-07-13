//
//  SettingView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/9/25.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var loginVM: LoginViewModel
    @EnvironmentObject var userSession: UserSession
    @State private var showLogoutAlert = false

    var body: some View {
        NavigationStack {
            List {
                Button("로그아웃") {
                    showLogoutAlert = true
                }
                .confirmationDialog(
                    "정말 로그아웃하시겠습니까?",
                    isPresented: $showLogoutAlert,
                    titleVisibility: .visible
                ) {
                    Button("확인", role: .destructive) {
                        loginVM.logout(userSession: userSession)
                    }
                    Button("취소", role: .cancel) { }
                }
                // 탈퇴 추후 확장
                NavigationLink("앱 정보", destination: AppInfoView())
            }
            .navigationTitle("설정")
        }
    }
}
