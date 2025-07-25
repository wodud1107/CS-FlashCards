//
//  FlashCardView.swift
//  CSFlashCards
//
//  Created by 김재영 on 7/8/25.
//

import SwiftUI

struct FlashCardView: View {
    @ObservedObject var viewModel: FlashCardViewModel

    @State private var isFlipped = false

    var body: some View {
        VStack {
            if let card = viewModel.currentCard {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.1))
                        .frame(height: 250)
                        .shadow(radius: 5)

                    VStack {
                        if isFlipped {
                            ScrollView {
                                Text(card.back)
                                    .font(.title)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            .frame(maxHeight:220)
                        } else {
                            Text(card.front)
                                .font(.title)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }

                HStack {
                    Button("Prev") {
                        viewModel.prevCard()
                        isFlipped = false
                    }
                        .disabled(viewModel.currentIndex == 0)
                    Spacer()
                    Button("Next") {
                        viewModel.nextCard()
                        isFlipped = false
                    }
                        .disabled(viewModel.currentIndex >= viewModel.cards.count - 1)
                }
                .padding(.horizontal, 40)
                .padding(.top, 24)
            } else {
                Text("No cards available.")
            }
        }
        .padding()
    }
}
