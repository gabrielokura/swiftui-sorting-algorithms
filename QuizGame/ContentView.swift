//
//  ContentView.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 31/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller = Controller()
    
    var body: some View {
        VStack {
            
            Text("Swap: \(controller.swapCounter)")
            
            HStack {
                ForEach(controller.rectangles) { current in
                    Rectangle()
                        .fill(current.color)
                        .frame(width: current.width, height: current.heigth)
                        .frame(height: 300, alignment: .bottom)
                }
            }
            .animation(.spring(), value: controller.rectangles)
            
            HStack {
                Button("Sort") {
                    controller.sort()
                }
                .padding()
                
                Button("Mix") {
                    controller.mix()
                }
                .padding()
            }
            .padding(.top, 50)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    @ViewBuilder
    func transactionMonitor(_ title: String, _ showAnimation: Bool = true) -> some View {
        transaction {
            print(title, terminator: showAnimation ? ": " : "\n")
            if showAnimation {
                print($0.animation ?? "nil")
            }
        }
    }
}
