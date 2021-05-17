//
//  TranslationViewController.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 14.05.2021.
//

import UIKit

class TranslationViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 250/255, green: 216/255, blue: 105/255, alpha: 1)
        
        setupViews()
    }
    
    lazy var languageSelector: LanguageSelectorView = {
        let selector = LanguageSelectorView()
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()
    
    @objc func sourceLanguageButtonTapped() {
        let sourceLanguageViewController = LanguagePickViewController()
        self.present(sourceLanguageViewController, animated: true, completion: nil)
    }
    
    @objc func resultLanguageButtonTapped() {
        let resultLanguageViewController = LanguagePickViewController()
        resultLanguageViewController.isSourceLanguage = false
        self.present(resultLanguageViewController, animated: true, completion: nil)
    }
    
    @objc func swapButtonTapped() {
        let tempTitle = languageSelector.sourceLanguageButton.currentTitle
        languageSelector.sourceLanguageButton.setTitle(languageSelector.resultLanguageButton.currentTitle, for: .normal)
        languageSelector.resultLanguageButton.setTitle(tempTitle, for: .normal)
    }
    
    lazy var translationField: TranslationFieldView = {
        let field = TranslationFieldView()
        field.layer.cornerRadius = 10
        field.sourceTextView.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    func updateSourceLanguage(language: String) {
        if language == languageSelector.resultLanguageButton.currentTitle {
            languageSelector.resultLanguageButton
                .setTitle(languageSelector.sourceLanguageButton.currentTitle, for: .normal)
            languageSelector.sourceLanguageButton.setTitle(language, for: .normal)
        } else {
            languageSelector.sourceLanguageButton.setTitle(language, for: .normal)
        }
    }
    
    func updateResultLanguage(language: String) {
        if language == languageSelector.sourceLanguageButton.currentTitle {
            languageSelector.sourceLanguageButton
                .setTitle(languageSelector.resultLanguageButton.currentTitle, for: .normal)
            languageSelector.resultLanguageButton.setTitle(language, for: .normal)
        } else {
            languageSelector.resultLanguageButton.setTitle(language, for: .normal)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        translationField.resultTextView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if (textView.text != " " && textView.text != "") {
            HTTPRequestApi.sharedInstance
                .fetchTranslation(phrase: textView.text,
                                  sourceLanguage: languageSelector.sourceLanguageButton.currentTitle!,
                                  resultLanguage: languageSelector.resultLanguageButton.currentTitle!) { (resultString: String) in
                    self.translationField.resultTextView.text = resultString
                    WordList.sharedWordList.addTranslation(phrase: textView.text, translation: resultString)
                    NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil)
                }
        }
    }
    
    private func setupViews() {
        view.addSubview(languageSelector)
        view.addSubview(translationField)

        languageSelector.sourceLanguageButton.addTarget(self, action: #selector(sourceLanguageButtonTapped), for: .touchUpInside)
        languageSelector.resultLanguageButton.addTarget(self, action: #selector(resultLanguageButtonTapped), for: .touchUpInside)
        languageSelector.swapLanguageButton.addTarget(self, action: #selector(swapButtonTapped), for: .touchUpInside)
        
        let languageSelectorConstraints = [
            languageSelector.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            languageSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            languageSelector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            languageSelector.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let translationFieldConstraints = [
            translationField.topAnchor.constraint(equalTo: languageSelector.bottomAnchor, constant: 16),
            translationField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            translationField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            translationField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(languageSelectorConstraints)
        NSLayoutConstraint.activate(translationFieldConstraints)
    }

}
