//
//  SearchResultsViewController.swift
//  iMeal
//
//  Created by Babek Gadirli on 10.10.23.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    var meals: [Recipe] = [Recipe]()
    
    // MARK: Properties
    
    public let resultsTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
        
        return tableView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.addSubview(resultsTableView)
        resultsTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
    }
    
}

// MARK: Tableview extensions

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
                
        cell.configureCell(with: meals[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        340
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = RecipeViewController()
        vc.configureView(with: meals[indexPath.row])
        present(vc, animated: true)
    }
    
    
}
