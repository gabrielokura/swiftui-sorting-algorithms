//
//  MenuView.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 03/08/23.
//

import SwiftUI

struct MenuView: View {
    var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("menu_logo")
                    .resizable()
                    .frame(maxWidth: 441, maxHeight: 72)
                    .padding(.bottom, 34)
                
                NavigationLink {
                   QuizView()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("alternativas"))
                            .frame(width: 208, height: 60)
                        
                        Text("PLAY")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
                .padding(.bottom, 10)
                
                Text("News soon...")
                    .foregroundColor(.black)
                    .font(.body)
            }
            .background {
                backgroundColor
            }
            .preferredColorScheme(.light)
        }
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
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
