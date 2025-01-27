//
//  APIEndpoint.swift
//  DummyApp


import Foundation

/// Protocol to define the structure of an API endpoint.
protocol APIEndpoint {
    /// Creates a URLRequest for the API endpoint.
    /// - Returns: A URLRequest instance or `nil` if the URL is invalid.
    func urlRequest() -> URLRequest?
}

/// Enum representing different API endpoints in the application.
enum AppEndPoint: APIEndpoint {
    case getCategory                 // Fetches a list of categories.
    case search(category: String)    // Searches meals based on the provided category.
    case allMeals                    // Fetches all available meals.

    /// The path for the API endpoint.
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

    /// The HTTP method for the API endpoint.
    var method: String {
        switch self {
        case .getCategory, .search, .allMeals:
            return "GET"
        }
    }
    
    static var currentBaseURL: URL = {
        #if DEBUG
        return URL(string: "https://www.themealdb.com/api/json/v1/1/")!
        #elseif TEST
        return URL(string: "https://api-test.example.com")!
        #else
        return URL(string: "https://api.example.com")!
        #endif
    }()

    /// The base URL for the API, depending on the build configuration.
    var baseURL: URL {
        return AppEndPoint.currentBaseURL
    }

    /// Constructs a URLRequest for the current endpoint.
    /// - Returns: A URLRequest if the URL is valid, otherwise `nil`.
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: baseURL.absoluteString + path) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}

