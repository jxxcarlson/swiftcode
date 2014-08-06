
// File: nonsense.playground
// -------------------------
//
// Description: produce pronounceable
// nonsense words, eg.
//
// 1: hira-zansa
// 2: siqe-ratse
// 3: sifo-dassa
// 4: tixi-furse
//
// These words are constructed from
// random consonant, vowel, and digraph
// patterns.  By contrast, here
// are words constructed from random
// letters:
// 
// 1: gjoh-xkcri
// 2: xxgg-jjqfh
// 3: mxsv-tngwh
// 4: ftkm-aakif
//
// The first set of words is produced
// by the function pattenedNonsense(),
// the second by pureNonsense9().
//

import Foundation



// Data on English:

let consonants = "bcdfghjklmnpqrstvwxyz"
let vowels = "aeiou"
let alphabet = "abcdefghijklmnopqrstuvwxyz"
let digrams = ["th", "he", "in", "er", "an", "re", "nd", "at", "on", "nt", "ha", "es", "st", "en", "ed", "to", "it", "ou", "ea", "hi", "is", "or", "ti", "as", "te", "et", "ng", "of", "al", "de", "se", "se", "sa", "si", "ar", "ve", "ra", "ld", "ur"]


// String extensions
// -----------------
//
// Example:
// 
//    alphabet.randString(4)
//
// produces a random string of length 4
// from the characters of the string
// alphabet.


extension  String {
    
    subscript (i: Int) -> Character {
        
        return Array(self)[i]
    }
    
    func randIndex() -> Int {
        
        let N = UInt32(countElements(self))
        
        let k = Int(arc4random_uniform(N))
        
        return k
    }
    
    func randChar() -> Character {
        
        let k = self.randIndex()
        
        return self[k]
        
    }
    
    func randString(N: Int) -> String {
        
        var output = ""
        
        for k in 1...N {
            
            output += self.randChar()
        }
        
        return output
    }
    
    
    
}


// Generic function for retrieving 
// a random element from an array.
//
// Example: 
//
// randElement(digrams)


func randElement<T>(array: [T]) -> T {
    
    let N = UInt32(countElements(array))
    let k = Int(arc4random_uniform(N))
    return array[k]
    
}


// Check whhether the character key is in the 
// string str:

func charInString(key: Character, str: String) -> Bool {
    
    var result = false
    
    for c in str {
        
        if c == key {
            
            return true
        }
    }
    
    return false
    
}

// Utility function for constructin arrays of digrams
// with given consonant-vowel distribution.

func digramMatches( a: String, b: String) -> [String] {
    
    var output: [String] = []
    for dg in digrams {
        if charInString(dg[0], a) && charInString(dg[1], b) {
            output += [dg]
        }
    }
    return output
}

// Arrays of digrams with given consonant-vowel distributions

let dgcv = digramMatches(consonants, vowels)
let dgvc = digramMatches(vowels, consonants)
let dgvv = digramMatches(vowels, vowels)
let dgcc = digramMatches(consonants, consonants)

[dgcv, dgvc, dgvv, dgcc].map(countElements)

func pureNonsense(N: Int) -> String {
    
    return alphabet.randString(N)
}

// Function patternedNonsense() produces
// a random string of the form
//
//  |cv|cv-c|vc||cv|,
// 
// where c = consonant, v = vowel,
// |cv| is a consonant-vowel digram,
// etc.

func patternedNonsense() -> String {
    
    var output = randElement(dgcv) + consonants.randChar()
    output += vowels.randChar()
    output += "-"
    output += consonants.randChar()
    output += randElement(dgvc)
    output += randElement(dgcv)
    
    return output
}

// Number of values of patternedNonsense = 7,347,060
let nn = 14*21*5*21*17*14
let na = 26*26*26*26*26*26*26*26*26
let ratio = Double(nn)/Double(na)
// ratio = about one-millionth

countElements(patternedNonsense())


for k in 1...10 {
    println("\(k): \(patternedNonsense())")
}

println()

func pureNonsense9() -> String {
    
    return pureNonsense(4)+"-"+pureNonsense(5)
}

for k in 1...10 {
    println("\(k): \(pureNonsense9())")
}

