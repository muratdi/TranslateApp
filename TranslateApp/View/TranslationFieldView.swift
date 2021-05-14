//
//  TranslationFieldView.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 14.05.2021.
//

import UIKit

class TranslationFieldView: UIView, UITextViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
    }
    
    let sourceTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = "Enter your text here..."
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 0.5)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let resultTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = "Some output here"
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    private func setupViews() {
        addSubview(sourceTextView)
        addSubview(separatorView)
        addSubview(resultTextView)
        
        let sourceTextViewConstraints = [
            sourceTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            sourceTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            sourceTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            sourceTextView.heightAnchor.constraint(equalToConstant: 140)
        ]
        
        let separatorViewConstraint = [
            separatorView.topAnchor.constraint(equalTo: sourceTextView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            separatorView.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        let resultTextViewConstraint = [
            resultTextView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 12),
            resultTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            resultTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            resultTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(sourceTextViewConstraints)
        NSLayoutConstraint.activate(separatorViewConstraint)
        NSLayoutConstraint.activate(resultTextViewConstraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
