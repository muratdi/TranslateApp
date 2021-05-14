//
//  DictionaryViewController.swift
//  TranslateApp
//
//  Created by Мурат Джаримов on 14.05.2021.
//

import UIKit

class DictionaryViewController: UITableViewController, UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        self.view.backgroundColor = .white
        
        setupTableView()
        setupSearch()
    }
    
    let searchController = UISearchController(searchResultsController: nil)

    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    private func setupTableView() {
        tableView.register(DictionaryTableViewCell.self, forCellReuseIdentifier: "cellid")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DictionaryTableViewCell()
        
        return cell
    }
    
}
