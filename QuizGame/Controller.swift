//
//  Controller.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 01/08/23.
//

import SwiftUI

class Controller: ObservableObject {
    @Published var rectangles: [GeometryComponent] = []
    @Published var swapCounter = 0
    
    private var heigths: [CGFloat] = [100, 200, 140, 40, 80, 260, 240, 160, 180, 60, 120]
    private let sorter: Sorter
    
    var initialState: [GeometryComponent] = []
    
    var cachedAnimation: [SwapAnimation]?
    
    init() {
        self.sorter = QuickSorter3()
        
        print("new sorter of type: \(sorter.type)")
        fillRectangles()
        self.initialState = rectangles
    }
    
    private func fillRectangles() {
        for heigth in heigths {
            rectangles.append(GeometryComponent.withDefaultValues(heigth))
        }
    }
    
    func sort() {
        if canUseCachedAnimation() {
            animate(cachedAnimation!)
            print("using cache")
            return
        }
        
        let animations = sorter.sort(components: rectangles)
        print("\(animations.count) iterações para o \(sorter.type)")
        
        animate(animations)
        cachedAnimation = animations
    }
    
    private func animate(_ animations: [SwapAnimation]) {
        var copy = animations
        
        if copy.isEmpty {
            return
        }
        
        let current = copy.removeFirst()
        rectangles = current.swap(rectangles)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animate(copy)
        }
    }
    
    func mix(){
        rectangles = initialState
        swapCounter = 0
    }
    
    func canUseCachedAnimation() -> Bool{
        return cachedAnimation != nil && rectangles == initialState
    }
}

class GeometryComponent: Identifiable, Equatable {
    static func == (lhs: GeometryComponent, rhs: GeometryComponent) -> Bool {
        lhs.id == rhs.id
    }
    
    var color: Color
    var width: CGFloat
    var heigth: CGFloat
    
    init(color: Color?, width: CGFloat?, heigth: CGFloat) {
        self.color = color ?? .black
        self.width = width ?? 10
        self.heigth = heigth
    }
    
    static func withDefaultValues(_ heigh: CGFloat) -> GeometryComponent{
        let component = GeometryComponent(color: nil, width: nil, heigth: heigh)
        return component
    }
}
