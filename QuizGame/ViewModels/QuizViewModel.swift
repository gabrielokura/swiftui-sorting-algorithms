//
//  QuizViewModel.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 04/08/23.
//

import Combine
import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var rectangles: [GeometryComponent] = []
    @Published var swapCounter = 0
    
    private var heigths: [CGFloat] = [190, 150, 100, 130, 50, 70, 200, 140, 40, 80, 20, 220, 160, 180, 60, 120, 10, 30, 110, 90]
    private var sorter: Sorter!
    private let sorters: [Sorter] = [BubbleSorter(), SelectionSorter(), InsertionSorter(), QuickSorter(), QuickSorter3(), RandomQuickSorter()]
    
    var initialState: [GeometryComponent] = []
    
    var cachedAnimation: [SwapAnimation]?
    @Published var animationSpeed: Speed = .high
    let paintAnimationSpeed = 0.03
    
    @Published var isAnimating = false
    @Published var isSorted = false
    
    @Published var progress: Double = 1.0
    
    @Published var alternativas: [String] = []
    
    var animationFrames = 0
    
    @Published var choosedAnswerIndex = 0
    @Published var correctAnswerIndex = 0
    @Published var showResult = false
    
    var sorterName: String {
        get {
           return sorter.type
        }
    }
    
    init() {
        setupSorterEAlternativas()
        fillRectangles()
        self.initialState = rectangles
        self.correctAnswerIndex = 3
    }
    
    private func setupSorterEAlternativas() {
        sorter = randomSorter()
        var copy = sorters
        
        copy.removeAll(where: { $0.type == sorterName })
        
        copy.shuffle()
        copy.remove(atOffsets: [0, 1])
        
        alternativas = copy.map({ current in
            return current.type
        })
        
        alternativas.append(sorterName)
        alternativas.shuffle()
    }
    
    private func fillRectangles() {
        heigths.sort()
        var colorRed = 0.0 //121 -> 140
        var colorGreen = 0.0 //147 -> 185
        var colorBlue = 0.0 // 182 -> 191
        
        let colunasTotal = heigths.count
        
        for heigth in heigths {
            let color = Color(red: 0.4745 + colorRed, green: 0.57647 + colorGreen, blue: 0.71372 + colorBlue)
            rectangles.append(GeometryComponent.withHeigthColor(heigh: heigth, color: color))
            
            colorRed += (Double(19)/Double(255))/Double(colunasTotal)
            colorGreen += (Double(38)/Double(255))/Double(colunasTotal)
            colorBlue += (Double(9)/Double(255))/Double(colunasTotal)
        }
        
        rectangles.shuffle()
    }
    
    func sort() {
        if isAnimating {
            return
        }
        
        isAnimating = true
        if canUseCachedAnimation() {
            animate(cachedAnimation!)
            return
        }
        
        let animations = sorter.sort(components: rectangles)
        animationFrames = animations.count
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
        self.progress = Double(copy.count) / Double(animationFrames)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.swapCounter += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationSpeed.value) {
            self.animate(copy)
        }
    }
    
    func mix(){
        if !isSorted {
            return
        }
        
        isAnimating = false
        isSorted = false
        rectangles = initialState
        swapCounter = 0
        progress = 1.0
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
    }
    
    func selecionarAlternativa(_ alternativa: String) {
        if alternativa == sorterName {
            print("acertou")
            correctAnswerIndex = alternativas.firstIndex(where: { $0 == alternativa })!
            choosedAnswerIndex = correctAnswerIndex
        } else {
            print("errou")
            choosedAnswerIndex = alternativas.firstIndex(where: { $0 == alternativa })!
            correctAnswerIndex = alternativas.firstIndex(where: { $0 == sorterName })!
        }
        
        showResult = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.startAgain()
        }
    }
    
    private func startAgain() {
        setupSorterEAlternativas()
        rectangles.shuffle()
        initialState = rectangles
        progress = 1
        swapCounter = 0
        isSorted = false
        isAnimating = false
        showResult = false
        cachedAnimation = nil
    }
    
    private func randomSorter() -> Sorter {
        let random = Int.random(in: 0 ..< sorters.count)
        return sorters[random]
    }
}
