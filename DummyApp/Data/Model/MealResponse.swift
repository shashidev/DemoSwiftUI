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
    
    init(idMeal : String? =  nil,
         strMeal : String? = nil,
         strDrinkAlternate : String? = nil,
         strCategory : String? = nil,
         strArea : String? = nil,
         strInstructions : String? = nil,
         strMealThumb : String? = nil) {
        
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strDrinkAlternate = strDrinkAlternate
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
    }
    
    var id: String { idMeal ?? "" }
    
    //For preview
    
    static let previewMeal = Meals(strMeal: "Chicken Handi", strDrinkAlternate: "", strCategory: "Chicken", strArea: "Indian",strInstructions: "STEP 1 - MARINATING THE CHICKEN\r\nIn a bowl, add chicken, salt, white pepper, ginger juice and then mix it together well.\r\nSet the chicken aside.\r\nSTEP 2 - RINSE THE WHITE RICE\r\nRinse the rice in a metal bowl or pot a couple times and then drain the water.\r\nSTEP 2 - BOILING THE WHITE RICE\r\nNext add 8 cups of water and then set the stove on high heat until it is boiling. Once rice porridge starts to boil, set the stove on low heat and then stir it once every 8-10 minutes for around 20-25 minutes.\r\nAfter 25 minutes, this is optional but you can add a little bit more water to make rice porridge to make it less thick or to your preference.\r\nNext add the marinated chicken to the rice porridge and leave the stove on low heat for another 10 minutes.\r\nAfter an additional 10 minutes add the green onions, sliced ginger, 1 pinch of salt, 1 pinch of white pepper and stir for 10 seconds.\r\nServe the rice porridge in a bowl\r\nOptional: add Coriander on top of the rice porridge.", strMealThumb: "https://www.themealdb.com/images/media/meals/wyxwsp1486979827.jpg")
    
    
}
