//
//  APIEndpoint.swift
//  DummyApp


import Foundation

// Enum to define all API endpoints
enum APIEndpoint {
    case getCategory
    case search(category: String)
    case allMeals
    
    var path: String {
        switch self {
        case .getCategory:
            return "/categories.php"
        case .search(let category):
            return "/search.php?s=\(category)"
        case .allMeals:
            return "/search.php?s"
        }
    }
    
    var method: String {
        switch self {
        case .getCategory, .search, .allMeals:
            return "GET"
        }
    }
    
    var baseURL: URL {
        // Base URLs for different environments (can be injected based on environment)
        #if DEBUG
        return URL(string: "https://www.themealdb.com/api/json/v1/1/")!
        #elseif TEST
        return URL(string: "https://api-test.example.com")!
        #else
        return URL(string: "https://api.example.com")!
        #endif
    }
    
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: baseURL.absoluteString + path) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
