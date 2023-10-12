//
//  APICaller.swift
//  iMeal
//
//  Created by Babek Gadirli on 03.10.23.
//

import Foundation

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    private let categoriesUrl = "https://www.themealdb.com/api/json/v1/1/categories.php"
    private let seaFoodUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    private let alchocolicDrinksUrl = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
    private let recipeUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    private let searchUrl = "https://www.themealdb.com/api/json/v1/1/search.php?s="
    private let randomUrl = "https://www.themealdb.com/api/json/v1/1/random.php"
    
    func getCategories(completion: @escaping (Result<[Category],Error>) -> ()) {
        
        guard let url = URL(string: categoriesUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                
                return
            }
            
            do {
                let results = try JSONDecoder().decode(CategoriesResult.self, from: data)
                
                completion(.success(results.categories))
            }
            catch {
                print("DEBUG: Error parsing Json")
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
        
        
    }
    
    func getFoodsByCategory(category: String, completion: @escaping (Result<[MealModel],Error>) -> ()) {
        
        guard let url = URL(string: seaFoodUrl + category) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MealResult.self, from: data)
                
                completion(.success(results.meals))
            }
            catch {
                print("DEBUG: Error parsing Json")
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
        
        
    }
    
    func getAlcoholicDrinks(completion: @escaping (Result<[Drink], Error>) -> ()) {
        guard let url = URL(string: alchocolicDrinksUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(DrinksResponse.self, from: data)
                completion(.success(results.drinks))
            } catch {
                completion(.failure(APIError.failedToGetData))
                print("DEBUG: Failed to get data from API")
            }
        }
        
        task.resume()
    }
    
    func getRecipeById(withID id: String, completion: @escaping (Result<[Recipe], Error>) -> ()) {
        guard let url = URL(string: recipeUrl+id) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(RecipeResult.self, from: data)
                completion(.success(results.meals))
            } catch {
                print("DEBUG: Error while fetching recipe \(error).")
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    
    func getSeachResults(withKey searchKey: String, completion: @escaping (Result<[Recipe], Error>) -> ()) {
        guard let url = URL(string: searchUrl+searchKey) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(RecipeResult.self, from: data)
                completion(.success(results.meals))
            } catch {
                print("DEBUG: Error while fetching recipe \(error).")
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getRandomRecipe(completion: @escaping (Result<[Recipe], Error>) -> () ) {
        guard let url = URL(string: randomUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(RecipeResult.self, from: data)
                completion(.success(results.meals))
            } catch {
                print("DEBUG: Error while fetching random recipe \(error).")
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
}
