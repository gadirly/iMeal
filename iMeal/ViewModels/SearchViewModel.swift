//
//  SearchViewModel.swift
//  iMeal
//
//  Created by Babek Gadirli on 10.10.23.
//

import Foundation

class SearchViewModel {
    var meals: [Recipe] = [Recipe]()
    
    func searchMeals(withKey key: String, completion: @escaping () -> ()) {
        meals.removeAll()
        APICaller.shared.getSeachResults(withKey: key) { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let result):
                strongSelf.meals = result
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
