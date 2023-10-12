//
//  Drinks.swift
//  iMeal
//
//  Created by Babek Gadirli on 05.10.23.
//

import Foundation

struct DrinksResponse: Codable {
    let drinks: [Drink]
}

// MARK: - Drink
struct Drink: Codable, MealItemsProtocol {
    let strDrink: String?
    let strDrinkThumb: String?
    let idDrink: String?
    
    var id: String {
        
        return idDrink ?? ""
    }
    
    var title: String {
        return strDrink ?? ""
    }
    
    var imageURL: String {
        return strDrinkThumb ?? ""
    }
}
