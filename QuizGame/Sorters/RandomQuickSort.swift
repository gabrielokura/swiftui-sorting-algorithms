//
//  RandomQuickSort.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 02/08/23.
//

class RandomQuickSorter: Sorter {
    var type: String = "Random Quick sort"
    var swapCounter: Int = 0
    
    func sort(components: [GeometryComponent]) -> [SwapAnimation] {
        var copy = components
        var swaps: [SwapAnimation] = []
        
        func randomQuickSort(_ list: inout [GeometryComponent], low: Int, high: Int) {
            if low < high {
                let pivotIndex = randomPartition(&list, low: low, high: high)
                randomQuickSort(&list, low: low, high: pivotIndex - 1)
                randomQuickSort(&list, low: pivotIndex + 1, high: high)
            }
        }
        
        func randomPartition(_ list: inout [GeometryComponent], low: Int, high: Int) -> Int {
            let randomIndex = Int.random(in: low...high)
            list.swapAt(randomIndex, high)
            swapCounter += 1
            swaps.append(SwapAnimation(firstIndex: randomIndex, secondIndex: high))
            
            return partition(&list, low: low, high: high)
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
        
        randomQuickSort(&copy, low: 0, high: copy.count - 1)
        return swaps
    }
}

