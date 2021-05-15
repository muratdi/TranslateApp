//
//  DictionaryViewController.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 14.05.2021.
//

import UIKit

class DictionaryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        self.view.backgroundColor = .white
        
        setupSearch()
    }
    
    let phraseList = WordList.sharedWordList.listOfPhrases
    let translationList = WordList.sharedWordList.listOfTranslations
    
    let searchController = UISearchController(searchResultsController: nil)

    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phraseList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DictionaryTableViewCell(style: .subtitle, reuseIdentifier: "cellid")
        
        let phrase = phraseList[indexPath.item]
        let translation = translationList[indexPath.item]
        cell.textLabel?.text = phrase
        cell.detailTextLabel?.text = translation
        
        return cell
    }
}

extension DictionaryViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
}
