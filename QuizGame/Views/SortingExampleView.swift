//
//  SortingExampleView.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 03/08/23.
//

import SwiftUI

struct SortingExampleView: View {
    @StateObject var viewModel = SortingExampleViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sort: \(viewModel.sorterName)")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Swap: \(viewModel.swapCounter)")
                    Spacer()
                    speedIndicator
                        .onTapGesture {
                            viewModel.increaseSpeed()
                        }
                }
                
                HStack {
                    ForEach(viewModel.rectangles) { current in
                        Rectangle()
                            .fill(current.color)
                            .frame(width: current.width, height: current.heigth)
                            .frame(height: 300, alignment: .bottom)
                    }
                }
                .animation(.spring(), value: viewModel.rectangles)
                
                
                HStack {
                    Button {
                        viewModel.sort()
                    } label: {
                        Image(systemName: viewModel.isAnimating || viewModel.isSorted ? "play" : "play.fill")
                            .font(.largeTitle)
                    }
                    .padding()
                    
                    Button {
                        viewModel.mix()
                    } label: {
                        Image(systemName: viewModel.isSorted ? "arrow.counterclockwise.circle.fill" : "arrow.counterclockwise.circle")
                            .font(.largeTitle)
                    }
                }
                .padding(.top, 50)
                
            }
            .padding(.horizontal, 40)
        .frame(maxHeight: .infinity)
        }
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

struct SortingExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SortingExampleView()
    }
}
