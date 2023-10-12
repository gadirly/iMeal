//
//  Recipe.swift
//  iMeal
//
//  Created by Babek Gadirli on 07.10.23.
//

import Foundation

// MARK: - Welcome
struct RecipeResult: Codable {
    let meals: [Recipe]
}

// MARK: - Meal
struct Recipe: Codable {
    
    let idMeal, strMeal, strCategory, strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String
    let strTags: String?
    
    var tags: [String]? {
        guard let strTags else {
            return nil
        }
        return strTags.components(separatedBy: ",")
    }
    
}
