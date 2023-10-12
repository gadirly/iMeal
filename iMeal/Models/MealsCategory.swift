//
//  MealsCategory.swift
//  iMeal
//
//  Created by Babek Gadirli on 03.10.23.
//


// MARK: - Welcome

protocol MealItemsProtocol {
    var id: String { get }
    var title: String { get }
    var imageURL: String { get }
}

struct CategoriesResult: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable, MealItemsProtocol {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
    
    var id: String {
        return idCategory
    }
    
    var title: String {
        return strCategory
    }
    
    var imageURL: String {
        return strCategoryThumb
    }
}
