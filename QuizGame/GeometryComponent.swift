//
//  GeometryComponent.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 03/08/23.
//

import SwiftUI

class GeometryComponent: Identifiable, Equatable {
    static func == (lhs: GeometryComponent, rhs: GeometryComponent) -> Bool {
        lhs.id == rhs.id
    }
    
    var color: Color
    var width: CGFloat
    var heigth: CGFloat
    
    init(color: Color?, width: CGFloat?, heigth: CGFloat) {
        self.color = color ?? .black
        self.width = width ?? 15
        self.heigth = heigth
    }
    
    static func withDefaultValues(_ heigh: CGFloat) -> GeometryComponent{
        let component = GeometryComponent(color: nil, width: nil, heigth: heigh)
        return component
    }
}
