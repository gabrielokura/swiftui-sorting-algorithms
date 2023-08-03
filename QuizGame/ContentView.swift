//
//  ContentView.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 31/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MenuView()
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
