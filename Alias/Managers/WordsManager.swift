//
//  WordsManager.swift
//  Alias
//
//  Created by Anatoliy Khramchenko on 08.09.2022.
//

import Foundation

class WordsManager {
    
    static let shared = WordsManager()
    
    private var words: Set<String> = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "24"
    ]
    private var currentRaund = Set<String>()
    private var prevRaund = Set<String>()
    
    
    private init() {}
    
    func getWord() -> String? {
        let word = words.randomElement()
        if let word = word {
            let _ = words.remove(word)
            currentRaund.insert(word)
            return word
        } else {
            return nil
        }
    }
    
    func finishRaund() {
        prevRaund.forEach { word in
            words.insert(word)
        }
        prevRaund = Set<String>()
        currentRaund.forEach { word in
            prevRaund.insert(word)
        }
        currentRaund = Set<String>()
    }
    
}
