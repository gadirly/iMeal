//
//  SeaMeals.swift
//  iMeal
//
//  Created by Babek Gadirli on 04.10.23.
//

import Foundation

struct MealResult: Codable {
    let meals: [MealModel]
}

// MARK: - Meal
struct MealModel: Codable, MealItemsProtocol {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    var id: String {
        return idMeal
    }
    
    var title: String {
        return strMeal
    }
    
    var imageURL: String {
        return strMealThumb
    }
}
