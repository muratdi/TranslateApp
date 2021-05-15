//
//  TranslationRequest.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 15.05.2021.
//

import Foundation

struct TranslationRequest: Codable {
    
    let sourceLanguageCode: String
    let targetLanguageCode: String
    let texts: [String]
}

//POST https://translate.api.cloud.yandex.net/translate/v2/translate

//    {
//        "sourceLanguageCode": "en",
//        "targetLanguageCode": "ru",
//        "texts": [
//            "hello"
//        ]
//    }
