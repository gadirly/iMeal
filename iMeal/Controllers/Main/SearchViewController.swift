//
//  SettingsViewController.swift
//  iMeal
//
//  Created by Babek Gadirli on 02.10.23.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = SearchViewModel()
    
    private let searchController: UISearchController = {
           let controller = UISearchController(searchResultsController: SearchResultsViewController())
           controller.searchBar.placeholder = "Search Meal"
           controller.searchBar.searchBarStyle = .minimal
           return controller
       }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Search Meals"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        searchController.searchResultsUpdater = self

    }
    
    // MARK: Helpers
    

}


// MARK: Extensions

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else {return}
        
        viewModel.searchMeals(withKey: query) { [weak self] in
            
            guard let meals = self?.viewModel.meals else {
                return
            }
            
            DispatchQueue.main.async {
                resultController.meals = meals
                resultController.resultsTableView.reloadData()
            }
        }
        
        }
        
    }
