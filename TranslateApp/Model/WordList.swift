//
//  WordList.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 15.05.2021.
//

import Foundation

class WordList {
    
    static let sharedWordList = WordList()
    
    var listOfPhrases = ["Machine", "Remote"] //= [String]()
    var listOfTranslations = ["Машина", "Удаленный"] //= [String]()
        
    func clearHistory() {
        listOfPhrases = []
        listOfTranslations = []
    }
    
    func addTranslation(phrase: String, translation: String) {
        listOfPhrases.insert(phrase, at: 0)
        listOfTranslations.insert(translation, at: 0)
    }
}
