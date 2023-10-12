//
//  HomeViewModel.swift
//  iMeal
//
//  Created by Babek Gadirli on 05.10.23.
//

import Foundation

class HomeViewModel {
    
    var seaFoodList: [MealModel] = [MealModel]()
    var beefFoodList: [MealModel] = [MealModel]()
    var alcoholicDrinks: [Drink] = [Drink]()
    var dessertsList: [MealModel] = [MealModel]()
    var recipe: Recipe?
    
    var categories: [Category] = [Category]()
    
    func getSeaFoods(completion: @escaping () -> ()) {
        APICaller.shared.getFoodsByCategory(category: "SeaFood") { [weak self] result in
            switch result {
            case .success(let result):
                self?.seaFoodList = result
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getBeefFoods(completion: @escaping () -> ()) {
        APICaller.shared.getFoodsByCategory(category: "Beef") { [weak self] result in
            switch result {
            case .success(let result):
                self?.beefFoodList = result
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getDesserts(completion: @escaping () -> ()) {
        APICaller.shared.getFoodsByCategory(category: "Dessert") { [weak self] result in
            switch result {
            case .success(let result):
                self?.dessertsList = result
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAlcoholicDrinks(completion: @escaping () -> ()) {
        APICaller.shared.getAlcoholicDrinks { [weak self] result in
            switch result {
            case .success(let alcoholicDrinks):
                self?.alcoholicDrinks = alcoholicDrinks
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRecipe(withID id: String, completion: @escaping () -> ()) {
        APICaller.shared.getRecipeById(withID: id) { [weak self] result in
            

            switch result {
            case .success(let recipeResult):
                self?.recipe = recipeResult[0]
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRandomRecipe(completion: @escaping () -> Void) {
        recipe = nil
        
        APICaller.shared.getRandomRecipe { result in
            switch result {
            case .success(let recipe):
                self.recipe = recipe[0]
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCategories(completion: @escaping () -> Void) {
        categories.removeAll()
        
        APICaller.shared.getCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
