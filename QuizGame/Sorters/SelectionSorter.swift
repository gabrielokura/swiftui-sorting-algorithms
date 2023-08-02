//
//  SelectionSorter.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 02/08/23.
//

//class SelectionSorter: Sorter {
//    var type: String = "Selection sort"
//    var swapCounter: Int = 0
//
//    // font: https://pt.wikipedia.org/wiki/Selection_sort#C++
//    func sort(components: [GeometryComponent]) -> [SwapAnimation]{
//        var copy = components
//        var swaps: [SwapAnimation] = []
//
//        for i in 0..<copy.count {
//            var minimumIndex = i
//
//            for j in (i+1)..<copy.count {
//                if copy[j].heigth < copy[minimumIndex].heigth {
//                    minimumIndex = j
//                }
//            }
//
//            let auxiliar = copy[i]
//            copy[i] = copy[minimumIndex]
//            copy[minimumIndex] = auxiliar
//
//            swaps.append(SwapAnimation(firstIndex: i, secondIndex: minimumIndex))
//            swapCounter += 1
//        }
//        return swaps
//    }
//}

class SelectionSorter: Sorter {
    var type: String = "Selection sort"
    var swapCounter: Int = 0
    
    func sort(components: [GeometryComponent]) -> [SwapAnimation] {
        var copy = components
        var swaps: [SwapAnimation] = []
        
        for i in 0..<copy.count - 1 {
            var minIndex = i
            
            for j in (i + 1)..<copy.count {
                if copy[j].heigth < copy[minIndex].heigth {
                    minIndex = j
                }
            }
            
            if minIndex != i {
                let temp = copy[i]
                copy[i] = copy[minIndex]
                copy[minIndex] = temp
                
                swapCounter += 1
                swaps.append(SwapAnimation(firstIndex: i, secondIndex: minIndex))
            }
        }
        
        return swaps
    }
}
