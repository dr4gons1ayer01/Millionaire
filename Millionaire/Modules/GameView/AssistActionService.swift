//
//  AssistActionService.swift
//  Millionaire
//
//  Created by artyom s on 25.07.2025.
//

import UIKit

protocol AssistActionServiceDelegate {
    func call(rightIndex: Int) -> Int // a, b, right x8
    func fif2fif(rightIndex: Int) -> (Int, Int) // right, and [a,b,c]
    func audience(rightIndex: Int) -> Int // a b c, right x7
}

final class AssistActionService: AssistActionServiceDelegate {
    
    func call(rightIndex: Int) -> Int {
        var options = [0,1,2,3]
        options.remove(at: rightIndex)

        let rand1 = [0,1,2].randomElement()!
        options.remove(at: rand1)
        let rand2 = [0,1].randomElement()!
        
        let elements = [rand1, rand2, rightIndex,rightIndex,rightIndex,rightIndex,rightIndex,rightIndex,rightIndex,rightIndex]
        return elements.randomElement()!
    }
    
    func fif2fif(rightIndex: Int) -> (Int, Int) {
        var options = [0,1,2,3]
        options.remove(at: rightIndex)
        let rand = options.randomElement()!
        return (rightIndex, rand)
    }
    
    func audience(rightIndex: Int) -> Int {
        var options = [0,1,2,3]
        options.remove(at: rightIndex)
        let rand1 = [0,1,2].randomElement()!
        options.remove(at: rand1)
        let rand2 = [0,1].randomElement()!
        options.remove(at: rand2)
        let rand3 = options.first!
        let elements = [rand1, rand2, rand3,rightIndex,rightIndex,rightIndex,rightIndex,rightIndex,rightIndex,rightIndex]
        return elements.randomElement()!
    }
    
    
}
