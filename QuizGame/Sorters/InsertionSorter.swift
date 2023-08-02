//
//  InsertionSorter.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 02/08/23.
//

class InsertionSorter: Sorter {
    var type: String = "Insertion sort"
    var swapCounter: Int = 0
    
    func sort(components: [GeometryComponent]) -> [SwapAnimation] {
        var copy = components
        var swaps: [SwapAnimation] = []
        
        for i in 1..<copy.count {
            var currentIndex = i
            
            while currentIndex > 0 && copy[currentIndex].heigth < copy[currentIndex - 1].heigth {
                let temp = copy[currentIndex]
                copy[currentIndex] = copy[currentIndex - 1]
                copy[currentIndex - 1] = temp
                
                currentIndex -= 1
                swapCounter += 1
                swaps.append(SwapAnimation(firstIndex: currentIndex, secondIndex: currentIndex + 1))
            }
        }
        
        return swaps
    }
}
