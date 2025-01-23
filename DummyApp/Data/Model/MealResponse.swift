//
//  MealResponse.swift
//  DummyApp
//

import Foundation

struct MealResponse : Codable {
    let meals : [Meals]?

    enum CodingKeys: String, CodingKey {

        case meals = "meals"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meals = try values.decodeIfPresent([Meals].self, forKey: .meals)
    }

}

struct Meals : Codable, Identifiable {
    let idMeal : String?
    let strMeal : String?
    let strDrinkAlternate : String?
    let strCategory : String?
    let strArea : String?
    let strInstructions : String?
    let strMealThumb : String?
    
    enum CodingKeys: String, CodingKey {
        
        case idMeal = "idMeal"
        case strMeal = "strMeal"
        case strDrinkAlternate = "strDrinkAlternate"
        case strCategory = "strCategory"
        case strArea = "strArea"
        case strInstructions = "strInstructions"
        case strMealThumb = "strMealThumb"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try values.decodeIfPresent(String.self, forKey: .idMeal)
        strMeal = try values.decodeIfPresent(String.self, forKey: .strMeal)
        strDrinkAlternate = try values.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try values.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try values.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions = try values.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try values.decodeIfPresent(String.self, forKey: .strMealThumb)
    }
    
    var id: String { idMeal ?? "" }
}
