//
//  AnswersCardView.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 04/08/23.
//

import SwiftUI

struct AnswersCardView: View {
    var respostas: [String]
    
    @ObservedObject var viewModel: QuizViewModel
    
    var callback: (_ respostaSelecionada: String) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.ultraThinMaterial)
            
            VStack {
                ForEach(0 ..< respostas.count, id: \.self) { i in
                    Button {
                        callback(respostas[i])
                    } label: {
                        ZStack{
                            if viewModel.showResult && i == viewModel.choosedAnswerIndex  {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(i == viewModel.correctAnswerIndex  ? .green : .red)
                                    .frame(width: 200, height: 45)
                            } else if viewModel.showResult && i == viewModel.correctAnswerIndex{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.green)
                                    .frame(width: 200, height: 45)
                            }
                            else {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color("alternativas"))
                                    .frame(width: 200, height: 45)
                            }
                            
                            Text(respostas[i])
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

struct AnswersCardView_Previews: PreviewProvider {
    static var previews: some View {
        AnswersCardView(
            respostas: ["Bubble Sort", "Quick Sort", "Quick Sort 3", "Insertion Sort"], viewModel: QuizViewModel()) { respostaSelecionada in
            print("apertou na \(respostaSelecionada)")
        }
    }
}
