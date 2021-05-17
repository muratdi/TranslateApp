//
//  WordList.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 15.05.2021.
//

import Foundation

class WordList {
    
    static let sharedWordList = WordList()

    var listOfWordPairs = [WordPair]()
        
    func clearHistory() {
        listOfWordPairs = []
    }
    
    func addTranslation(phrase: String, translation: String) {
        let newElement = WordPair(phrase: phrase, translation: translation)
        listOfWordPairs.insert(newElement, at: 0)
    }
}
