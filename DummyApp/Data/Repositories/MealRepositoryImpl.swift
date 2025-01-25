//
//  MealRepository.swift
//  DummyApp
//

import Foundation
import Combine

/// A concrete implementation of `MealRepository` that handles fetching meal data from a network service.
class MealRepositoryImpl: MealRepository {
    
    /// The network service instance used for making API requests.
    private var networking: NetworkService
    
    /// Initializes the `MealRepositoryImpl` with a default or provided network service.
    /// - Parameter networking: The network service used for API requests (default is `NetworkManager`).
    init(networking: NetworkService = NetworkManager()) {
        self.networking = networking
    }
    
    /// Fetches meals for a specific category from the network and returns a publisher.
    /// - Parameter category: The category of meals to fetch. If the category is "All", all meals are fetched.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func fetchMeal(for category: String) -> AnyPublisher<[Meals], NetworkError> {
        return networking.request(endpoint: category == "All" ? AppEndPoint.allMeals : AppEndPoint.search(category: category))
            // Maps the response to an array of Meals, throwing an error if the response is invalid.
            .tryMap { (response: MealResponse) -> [Meals] in
                guard let items = response.meals else {
                    throw NetworkError.invalidResponse
                }
                return items
            }
            // Maps any errors to the `NetworkError` type.
            .mapError { error -> NetworkError in
                return error as? NetworkError ?? .unknown
            }
            // Converts the result to a type-erased publisher.
            .eraseToAnyPublisher()
    }
    
    /// Fetches all meals from the network and returns a publisher.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func fetchAllMeal() -> AnyPublisher<[Meals], NetworkError> {
        return networking.request(endpoint: AppEndPoint.allMeals)
            // Maps the response to an array of Meals, throwing an error if the response is invalid.
            .tryMap { (response: MealResponse) -> [Meals] in
                guard let items = response.meals else {
                    throw NetworkError.invalidResponse
                }
                return items
            }
            // Maps any errors to the `NetworkError` type.
            .mapError { error -> NetworkError in
                return error as? NetworkError ?? .unknown
            }
            // Converts the result to a type-erased publisher.
            .eraseToAnyPublisher()
    }
}


