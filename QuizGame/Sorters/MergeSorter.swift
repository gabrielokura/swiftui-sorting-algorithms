//
//  MergeSorter.swift
//  QuizGame
//
//  Created by Gabriel Motelevicz Okura on 02/08/23.
//

//TODO: fix this sorter
class MergeSorter: Sorter {
    var type: String = "Merge sort"
    var swapCounter: Int = 0
    
    func sort(components: [GeometryComponent]) -> [SwapAnimation] {
        var copy = components
        var swaps: [SwapAnimation] = []
        
        func mergeSort(_ list: [GeometryComponent]) -> [GeometryComponent] {
            guard list.count > 1 else { return list }
            
            let middleIndex = list.count / 2
            let leftHalf = mergeSort(Array(list[..<middleIndex]))
            let rightHalf = mergeSort(Array(list[middleIndex...]))
            
            return merge(leftHalf, rightHalf)
        }
        
        func merge(_ left: [GeometryComponent], _ right: [GeometryComponent]) -> [GeometryComponent] {
            var mergedList: [GeometryComponent] = []
            var leftIndex = 0
            var rightIndex = 0
            
            while leftIndex < left.count && rightIndex < right.count {
                if left[leftIndex].heigth < right[rightIndex].heigth {
                    mergedList.append(left[leftIndex])
                    leftIndex += 1
                } else {
                    mergedList.append(right[rightIndex])
                    rightIndex += 1
                }
                
                swapCounter += 1
                swaps.append(SwapAnimation(firstIndex: leftIndex, secondIndex: rightIndex))
            }
            
            mergedList.append(contentsOf: left[leftIndex...])
            mergedList.append(contentsOf: right[rightIndex...])
            
            return mergedList
        }
        
        copy = mergeSort(copy)
        return swaps
    }
}

