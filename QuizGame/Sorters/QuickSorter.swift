//
//  QuickSorter.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 02/08/23.
//

class QuickSorter: Sorter {
    var type: String = "Quick sort"
    var swapCounter: Int = 0
    
    func sort(components: [GeometryComponent]) -> [SwapAnimation] {
        var copy = components
        var swaps: [SwapAnimation] = []
        
        func quickSort(_ list: inout [GeometryComponent], low: Int, high: Int) {
            if low < high {
                let pivotIndex = partition(&list, low: low, high: high)
                quickSort(&list, low: low, high: pivotIndex - 1)
                quickSort(&list, low: pivotIndex + 1, high: high)
            }
        }
        
        func partition(_ list: inout [GeometryComponent], low: Int, high: Int) -> Int {
            let pivot = list[high]
            var i = low - 1
            
            for j in low..<high {
                if list[j].heigth <= pivot.heigth {
                    i += 1
                    list.swapAt(i, j)
                    swapCounter += 1
                    swaps.append(SwapAnimation(firstIndex: i, secondIndex: j))
                }
            }
            
            list.swapAt(i + 1, high)
            swapCounter += 1
            swaps.append(SwapAnimation(firstIndex: i + 1, secondIndex: high))
            
            return i + 1
        }
        
        quickSort(&copy, low: 0, high: copy.count - 1)
        return swaps
    }
}

