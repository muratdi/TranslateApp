//
//  LanguageSelectorView.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 14.05.2021.
//

import UIKit

class LanguageSelectorView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let swapLanguageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "change")?.withTintColor(.darkGray), for: .normal)
        button.contentMode = .scaleAspectFill
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    let sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("English", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .right
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return button
    }()
    
    let resultLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Russian", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return button
    }()

    private func setupViews() {
        axis = NSLayoutConstraint.Axis.horizontal
        distribution = UIStackView.Distribution.fillEqually
        alignment = UIStackView.Alignment.center
        spacing = 4
        
        addArrangedSubview(sourceLanguageButton)
        addArrangedSubview(swapLanguageButton)
        addArrangedSubview(resultLanguageButton)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
