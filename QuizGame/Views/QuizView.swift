//
//  QuizView.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 04/08/23.
//

import SwiftUI

struct QuizView: View {
    @StateObject var viewModel = QuizViewModel()
    let height: CGFloat = 260
    
    var body: some View {
        
        VStack (alignment: .center) {
            Text("Can you guess which sorting algorithm this is?")
                .font(.title)
                .fontWeight(.bold)
            
            HStack(alignment: .top) {
                VStack (alignment: .leading) {
                    rectanglesAnimated
                        .padding(.horizontal, 25)
                        .background {
                            ZStack (alignment: .top) {
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    
                                progressIndicator
                                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            
                        }
                    
                    buttons
                        .padding(.horizontal, 10)
                }
                
                AnswersCardView(respostas: viewModel.alternativas, viewModel: viewModel) { respostaSelecionada in
                    viewModel.selecionarAlternativa(respostaSelecionada)
                }
                .frame(maxWidth: 250, maxHeight: height)
            }
            
        }
        .padding()
        .navigationBarBackButtonHidden()
        .background{
            backgroundColor
        }
        .preferredColorScheme(.light)
        
    }
    
    var backgroundColor: some View {
        ZStack {
            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(Color("background"))
                .blur(radius: 160)
                .padding(.trailing, 800)
                .padding(.bottom, 200)
            
            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(Color("background"))
                .blur(radius: 160)
                .padding(.leading, 800)
                .padding(.top, 200)
                
        }
        .zIndex(-1)
        .ignoresSafeArea()
    }
    
    var progressIndicator: some View {
        ProgressView(value: viewModel.progress)
            .tint(Color("background"))
            .scaleEffect(x: 1, y: 4, anchor: .center)
            .animation(.easeIn, value: viewModel.progress)
    }
    
    var buttons: some View {
        HStack (spacing: 20) {
            Button {
                viewModel.sort()
            } label: {
                Image(systemName: viewModel.isAnimating || viewModel.isSorted ? "play" : "play.fill")
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            Button {
                viewModel.mix()
            } label: {
                Image(systemName: viewModel.isSorted ? "arrow.counterclockwise.circle.fill" : "arrow.counterclockwise.circle")
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            speedIndicator
                .onTapGesture {
                    viewModel.increaseSpeed()
                }
        }
    }
    
    var rectanglesAnimated: some View {
        HStack {
            ForEach(viewModel.rectangles) { current in
                Rectangle()
                    .fill(current.color)
                    .frame(height: current.heigth)
                    .cornerRadius(25)
                    .frame(height: height, alignment: .bottom)
            }
        }
        .animation(.spring(), value: viewModel.rectangles)
    }
    
    @ViewBuilder
    var speedIndicator: some View {
        HStack {
            switch viewModel.animationSpeed {
            case .normal:
                HStack {
                    Image(systemName: "play.fill")
                }
            case .high:
                HStack {
                    Image(systemName: "play.fill")
                    Image(systemName: "play.fill")
                        .padding(.leading, -10)
                }
            case .veryHigh:
                HStack {
                    Image(systemName: "play.fill")
                    Image(systemName: "play.fill")
                        .padding(.leading, -10)
                    Image(systemName: "play.fill")
                        .padding(.leading, -10)
                }
                
            }
            
            Text(viewModel.animationSpeed.name)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
