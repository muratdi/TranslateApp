//
//  SettingsViewController.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 14.05.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        self.view.backgroundColor = .white
        
        view.addSubview(settingsLabel)
        settingsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        settingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "This tab is under development"
        label.textColor = UIColor(red: 250/255, green: 216/255, blue: 105/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
