//
//  SourceLanguageViewController.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 15.05.2021.
//

import UIKit

class LanguagePickViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupTableView()
    }
    
    var isSourceLanguage = true
    
    let availableLanguages = ["English", "Russian", "Spanish"]
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }()
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellid")
        cell.textLabel?.text = availableLanguages[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenLanguage = availableLanguages[indexPath.item]
        if let presenter = presentingViewController?.children[0] as? TranslationViewController {
            if isSourceLanguage {
                presenter.updateSourceLanguage(language: chosenLanguage)
            } else {
                presenter.updateResultLanguage(language: chosenLanguage)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
}
