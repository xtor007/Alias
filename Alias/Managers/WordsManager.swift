//
//  WordsManager.swift
//  Alias
//
//  Created by Anatoliy Khramchenko on 08.09.2022.
//

import Foundation

class WordsManager {
    
    static let shared = WordsManager()
    
    private var words: Set<String> = {
        var data = Set<String>()
        let path = Bundle.main.path(forResource: "Words", ofType: "plist")
        if let path = path {
            let words = NSArray(contentsOfFile: path)
            if let words = words {
                words.forEach { element in
                    if let element = element as? String {
                        data.insert(element)
                    }
                }
            }
        }
        return data
    }()
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
