//
//  BubbleSorter.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 02/08/23.
//

class BubbleSorter: Sorter {
    var type: String = "Bubble sort"
    var swapCounter: Int = 0
    
    func sort(components: [GeometryComponent]) -> [SwapAnimation]{
        var copy = components
        var swapped = false
        var swaps: [SwapAnimation] = []
        
        repeat {
            swapped = false
            
            for i in 0..<(copy.count - 1) {
                let current = copy[i]
                let next = copy[i+1]
                
                if current.heigth > next.heigth {
                    copy[i] = next
                    copy[i + 1] = current
                    swapCounter += 1
                    swapped = true
                    swaps.append(SwapAnimation(firstIndex: i, secondIndex: i+1))
                }
            }
        } while swapped
        
        return swaps
    }
}
