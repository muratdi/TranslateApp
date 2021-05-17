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
    let iamToken = "t1.9euelZqRyonIy8-ejpmVjs2PlZPHzu3rnpWam8jNloyLi83Hz8yNlJiJisfl9PcxeXZ6-e9kClLj3fT3cSd0evnvZApS4w.XbEaZyiSe9Ez9Z9-LHRrl0-2E-qA_KOPFbXOQkpZCdHsknYrUMTz_v1rBnGrTL2IK166y-XCj-MGhqYOgCnOBw"
    
    func fetchTranslation(phrase: String, sourceLanguage: String, resultLanguage: String, completion: @escaping (String) ->()) {
        let url = URL(string: "https://translate.api.cloud.yandex.net/translate/v2/translate")
        guard let requestUrl = url else { fatalError() }
        
        //let texts = phrase.split(separator: " ")
        
        let json: [String: Any] = ["sourceLanguageCode": setLanguageCode(language: sourceLanguage),
                                   "targetLanguageCode": setLanguageCode(language: resultLanguage),
                                   "texts": phrase,
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
            
            do {
                let responseJson: TranslationResponse = try JSONDecoder().decode(TranslationResponse.self, from: data)
                var resultArray = [String?]()
                for item in responseJson.translations {
                    resultArray.append(item.text)
                }
                let newResultArray = resultArray.compactMap { $0 }
                let resultString = newResultArray.joined(separator: " ")
                
                DispatchQueue.main.async {
                    completion(resultString)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        
    }
    
    // curl -d "{\"yandexPassportOauthToken\":\"AQAAAAAiejYtAATuwcihMWxuuEVMl4d7yMqixPg\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens"
    
    private func setLanguageCode(language: String) -> (String) {
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
