//
//  TranslationResponse.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 15.05.2021.
//

import Foundation

struct TranslationResponse: Codable {
    
    let translations: [Translations]
}

struct Translations: Codable {
    let text: String?
}

extension TranslationResponse: Sequence {
    func makeIterator() -> Array<Translations>.Iterator {
      return translations.makeIterator()
    }
  }
