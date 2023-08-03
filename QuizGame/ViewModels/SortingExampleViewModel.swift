//
//  SortingExampleViewModel.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 03/08/23.
//

import SwiftUI

enum Speed {
    case normal, high, veryHigh
    
    var value: Double {
        switch self {
        case .normal:
            return 0.3
        case .high:
            return 0.1
        case .veryHigh:
            return 0.03
        }
    }
    
    var name: String {
        switch self {
        case .normal:
            return "1x"
        case .high:
            return "2x"
        case .veryHigh:
            return "3x"
        }
    }
}

class SortingExampleViewModel: ObservableObject {
    @Published var rectangles: [GeometryComponent] = []
    @Published var swapCounter = 0
    
    private var heigths: [CGFloat] = [100, 200, 140, 40, 80, 260, 240, 160, 180, 60, 120]
    private let sorter: Sorter
    
    var initialState: [GeometryComponent] = []
    
    var cachedAnimation: [SwapAnimation]?
    @Published var animationSpeed: Speed = .high
    let paintAnimationSpeed = 0.03
    
    @Published var isAnimating = false
    @Published var isSorted = false
    
    var sorterName: String {
        get {
           return sorter.type
        }
    }
    
    init() {
        self.sorter = QuickSorter3()
        fillRectangles()
        self.initialState = rectangles
    }
    
    private func fillRectangles() {
        for heigth in heigths {
            rectangles.append(GeometryComponent.withDefaultValues(heigth))
        }
    }
    
    func sort() {
        isAnimating = true
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
        if !isAnimating {
            return
        }
        
        var copy = animations
        
        if copy.isEmpty {
            finishSort()
            return
        }
        
        let current = copy.removeFirst()
        rectangles = current.swap(rectangles)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.swapCounter += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationSpeed.value) {
            self.animate(copy)
        }
    }
    
    func mix(){
        isAnimating = false
        isSorted = false
        rectangles = initialState
        swapCounter = 0
        resetColors()
    }
    
    private func canUseCachedAnimation() -> Bool{
        return cachedAnimation != nil && rectangles == initialState
    }
    
    func increaseSpeed() {
        switch animationSpeed {
        case .normal:
            animationSpeed = .high
        case .high:
            animationSpeed = .veryHigh
        case .veryHigh:
            animationSpeed = .normal
        }
    }
    
    private func finishSort() {
        isAnimating = false
        isSorted = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.paintAnimation(0)
        }
    }
    
    private func paintAnimation(_ index: Int) {
        if index == rectangles.count {
            return
        }
 
        let auxiliar = rectangles[index]
        auxiliar.color = .green
        
        rectangles[index] = auxiliar
        
        DispatchQueue.main.asyncAfter(deadline: .now() + paintAnimationSpeed) {
            self.paintAnimation(index + 1)
        }
    }
    
    private func resetColors() {
        for rectangle in rectangles {
            rectangle.color = .black
        }
    }
}
