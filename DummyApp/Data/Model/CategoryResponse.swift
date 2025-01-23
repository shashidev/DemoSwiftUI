//
//  CategoryResponse.swift
//  DummyApp
//
//

import Foundation

// MARK: - Category Model
struct CategoryResponse : Codable {
    let categories : [Categories]?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
    }
    
    init(categories : [Categories]?) {
        self.categories = categories
    }

}

struct Categories : Codable, Identifiable {
    let idCategory : String?
    let strCategory : String?
    let strCategoryThumb : String?
    let strCategoryDescription : String?

    enum CodingKeys: String, CodingKey {

        case idCategory = "idCategory"
        case strCategory = "strCategory"
        case strCategoryThumb = "strCategoryThumb"
        case strCategoryDescription = "strCategoryDescription"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idCategory = try values.decodeIfPresent(String.self, forKey: .idCategory)
        strCategory = try values.decodeIfPresent(String.self, forKey: .strCategory)
        strCategoryThumb = try values.decodeIfPresent(String.self, forKey: .strCategoryThumb)
        strCategoryDescription = try values.decodeIfPresent(String.self, forKey: .strCategoryDescription)
    }

    var id: String { idCategory ?? "" }
    
    init(idCategory : String? = nil, strCategory : String? = nil, strCategoryThumb : String? = nil, strCategoryDescription : String? = nil) {
        self.idCategory = idCategory
        self.strCategory = strCategory
        self.strCategoryThumb = strCategoryThumb
        self.strCategoryDescription = strCategoryDescription
    }
    
    static let dummuCategory = Categories(idCategory: "123", strCategory: "Dessert", strCategoryThumb: "https://www.themealdb.com//images//category//chicken.png", strCategoryDescription: "Dessert is a course that concludes a meal. The course usually consists of sweet foods, such as confections dishes or fruit, and possibly a beverage such as dessert wine or liqueur, however in the United States it may include coffee, cheeses, nuts, or other savory items regarded as a separate course elsewhere. In some parts of the world, such as much of central and western Africa, and most parts of China, there is no tradition of a dessert course to conclude a meal.\r\n\r\nThe term dessert can apply to many confections, such as biscuits, cakes, cookies, custards, gelatins, ice creams, pastries, pies, puddings, and sweet soups, and tarts. Fruit is also commonly found in dessert courses because of its naturally occurring sweetness. Some cultures sweeten foods that are more commonly savory to create desserts.")
    
}
