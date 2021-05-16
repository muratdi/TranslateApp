//
//  HTTPRequestApi.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 16.05.2021.
//

import Foundation

class HTTPRequestApi {
    static let sharedInstance = HTTPRequestApi()
    
    let folderName = "b1gepse5ftp1b58k9s3m"
    let iamToken = "t1.9euelZqRyonIy8-ejpmVjs2PlZPHzu3rnpWam8jNloyLi83Hz8yNlJiJisfl8_dwFXt6-e8RTj5J_d3z9zBEeHr57xFOPkn9.CLkNlLvs7sj3O8anq7H2HeMIOquNqMrhQ2W6WspPR9OKtCGJtJElDZTSyJOz6bR_8_ce11PrC3-zRwdpAARiDQ"
    
    func fetchTranslation(phrase: String, sourceLanguage: String, resultLanguage: String, completion: (String) ->()) {
        let url = URL(string: "https://translate.api.cloud.yandex.net/translate/v2/translate")
        guard let requestUrl = url else { fatalError() }
        
        let texts = phrase.split(separator: " ")
        
        let json: [String: Any] = ["sourceLanguageCode": setLanguageCode(language: sourceLanguage),
                                   "targetLanguageCode": setLanguageCode(language: resultLanguage),
                                   "texts": texts,
                                   "folderId": folderName
                                   ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: requestUrl)
        request.addValue("Bearer " + iamToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
//            let decoder = JSONDecoder()
//            let response: [TranslationResponse] = try? decoder.decode(TranslationResponse.self, from: data)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
        
    }
    
    // curl -d "{\"yandexPassportOauthToken\":\"AQAAAAAiejYtAATuwcihMWxuuEVMl4d7yMqixPg\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens"
    
    func setLanguageCode(language: String) -> (String) {
        switch language {
        case "Russian":
            return "ru"
        case "English":
            return "en"
        case "Spanish":
            return "es"
        default:
            return ""
        }
    }
}
