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
    
    func loadHistory() {
        if let data = UserDefaults.standard.value(forKey:"wordList") as? Data {
            do {
                listOfWordPairs = try PropertyListDecoder().decode([WordPair].self, from: data)
            } catch let historyLoadingError {
                print(historyLoadingError)
            }
        }
    }
    
    func clearHistory() {
        listOfWordPairs = []
        UserDefaults.standard.set(try? PropertyListEncoder().encode(listOfWordPairs), forKey:"wordList")
    }
    
    func addTranslation(phrase: String, translation: String) {
        let newElement = WordPair(phrase: phrase, translation: translation)
        listOfWordPairs.insert(newElement, at: 0)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(listOfWordPairs), forKey:"wordList")
    }
}
