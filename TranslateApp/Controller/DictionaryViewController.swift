//
//  DictionaryViewController.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 14.05.2021.
//

import UIKit

class DictionaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        self.view.backgroundColor = .white
        
        setupTableView()
        setupSearch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: NSNotification.Name("refresh"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearHistory))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    lazy var tableView: UITableView = {
        var tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }

    @objc func refreshTable(notification: NSNotification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func clearHistory() {
        WordList.sharedWordList.clearHistory()
        self.tableView.reloadData()
    }
    
    // search magic starts here:
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredPhrases = WordList.sharedWordList.listOfPhrases.filter { (phrase: String) -> Bool in
            return phrase.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    var filteredPhrases = [String]()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
}

extension DictionaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPhrases.count
        }
        
        return WordList.sharedWordList.listOfPhrases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellid")
        let phrase: String
        let translation: String
        
        if isFiltering {
            phrase = filteredPhrases[indexPath.item]
            translation = filteredPhrases[indexPath.item]
        } else {
            phrase = WordList.sharedWordList.listOfPhrases[indexPath.item]
            translation = WordList.sharedWordList.listOfTranslations[indexPath.item]
        }

        cell.textLabel?.text = phrase
        cell.detailTextLabel?.text = translation
        return cell
    }
}

extension DictionaryViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
