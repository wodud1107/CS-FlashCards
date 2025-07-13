//
//  AppInfoView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/9/25.
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("앱 정보")
                    .font(.title2).bold()
                Divider()
                Text("""
                이 앱은 jwasham의 "computer-science-flash-cards" 오픈소스 프로젝트의 플래시카드 데이터베이스(cards-jwasham.db)를 활용합니다.

                원본 프로젝트: https://github.com/jwasham/computer-science-flash-cards
                라이선스: MIT License

                플래시카드 데이터의 저작권은 jwasham에게 있습니다.
                본 앱은 MIT 라이선스 조건을 준수합니다.

                © jwasham / MIT License
                """)
                .font(.callout)
                Text("""
                This app uses the flashcard database (cards-jwasham.db) from the open-source project
                "computer-science-flash-cards" by jwasham.

                - Original project: https://github.com/jwasham/computer-science-flash-cards
                - License: MIT License

                The copyright of the flashcard data belongs to jwasham.
                This app complies with the MIT License terms.

                © jwasham / MIT License
                """)
                .font(.callout)
                .padding(.top, 6)
            }
            .padding()
        }
    }
}
