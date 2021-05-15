//
//  WordList.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 15.05.2021.
//

import Foundation

class WordList {
    
    static let sharedWordList = WordList()
    
    private(set) var listOfPhrases: [String] = ["Machine", "Remote"]
    private(set) var listOfTranslations: [String] = ["Машина", "Удаленный"]
        
    func clearHistory() {
        listOfPhrases = []
        listOfTranslations = []
    }
    
    func addTranslation(of phrase: String, with translation: String) {
        listOfPhrases.append(phrase)
        listOfTranslations.append(translation)
    }
}
