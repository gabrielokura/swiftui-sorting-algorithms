//
//  Sorter.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 01/08/23.
//

import Foundation

protocol Sorter {
    var type: String { get }
    var swapCounter: Int { get set }
    func sort(components: [GeometryComponent]) -> ([SwapAnimation])
}

class SwapAnimation {
    let firstIndex: Int
    let secondIndex: Int
    
    var duration: TimeInterval = 0.5
    
    init(firstIndex: Int, secondIndex: Int, duration: TimeInterval) {
        self.firstIndex = firstIndex
        self.secondIndex = secondIndex
        self.duration = duration
    }
    
    init(firstIndex: Int, secondIndex: Int) {
        self.firstIndex = firstIndex
        self.secondIndex = secondIndex
    }
    
    func swap(_ list: [GeometryComponent]) -> [GeometryComponent] {
        var copy = list
        
        copy[firstIndex] = list[secondIndex]
        copy[secondIndex] = list[firstIndex]
        return copy
    }
}
