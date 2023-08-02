//
//  QuickSorter3.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 02/08/23.
//

class QuickSorter3: Sorter {
    var type: String = "Quick Sort 3"
    var swapCounter: Int = 0
    
    func sort(components: [GeometryComponent]) -> [SwapAnimation] {
        var copy = components
        var swaps: [SwapAnimation] = []
        
        func quickSort3(_ list: inout [GeometryComponent], low: Int, high: Int) {
            if low >= high { return }
            
            var lt = low
            var gt = high
            var i = low + 1
            let pivot = list[low]
            
            while i <= gt {
                if list[i].heigth < pivot.heigth {
                    list.swapAt(lt, i)
                    swapCounter += 1
                    swaps.append(SwapAnimation(firstIndex: lt, secondIndex: i))
                    lt += 1
                    i += 1
                } else if list[i].heigth > pivot.heigth {
                    list.swapAt(i, gt)
                    swapCounter += 1
                    swaps.append(SwapAnimation(firstIndex: i, secondIndex: gt))
                    gt -= 1
                } else {
                    i += 1
                }
            }
            
            quickSort3(&list, low: low, high: lt - 1)
            quickSort3(&list, low: gt + 1, high: high)
        }
        
        quickSort3(&copy, low: 0, high: copy.count - 1)
        return swaps
    }
}

