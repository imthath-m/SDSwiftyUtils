//
//  main.swift
//  UtilitiesExample
//
//  Created by Imthath M on 28/03/19.
//  Copyright © 2019 Sky Dev. All rights reserved.
//

import Foundation

//let innova = Vehicle(brand: "Toyata", model: "TI-1025", seatingCapacity: 7)
//print(innova.jsonString!)
//
//var swift = Vehicle(brand: "Maruti", model: nil, seatingCapacity: 5)
////swift.model = "A-638"
//print(swift.jsonString!)

//let numbers = [1, 2, 3, 4, 5, 6]
//print(numbers.repeatingList(of: 8))

//var numbers = [1,2,3,4,5,6,4,2,6,4,1,1,7,8]
//
//numbers.uniqueCount().forEach { key, value in
//    print("\(key) is present \(value) times")
//}

func find(word: String, in sentence: String) -> Int {
    for (index, character) in sentence.enumerated() {
        var nextChar = character
        for (ind, char) in word.enumerated() {
            if char != nextChar { break }
            if char == word.last { return index }
            nextChar = sentence[index + ind + 1]
        }
    }
    return 0
}

extension String {
    subscript(position: Int) -> Element {
        return self[self.index(startIndex, offsetBy: position)]
    }
}

let sentence = "this is the test sentence"
let word = "sent"
print(find(word: word, in: sentence))

let sentenceArray: [Character] = Array(sentence)
let wordArray: [Character] = Array(word)
print(sentenceArray.findMatchingSubArray(like: wordArray))
