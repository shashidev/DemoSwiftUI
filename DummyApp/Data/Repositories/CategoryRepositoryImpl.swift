//
//  FoodItemRepository.swift
//  DummyApp
//


import Foundation
import Combine

/// A concrete implementation of `CategoryRepository` that handles fetching category data from a network service.
class CategoryRepositoryImpl: CategoryRepository {
    
    /// The network service instance used for making API requests.
    private var networking: NetworkService
    
    /// Initializes the `CategoryRepositoryImpl` with a default or provided network service.
    /// - Parameter networking: The network service used for API requests (default is `NetworkManager`).
    init(networking: NetworkService = NetworkManager()) {
        self.networking = networking
    }
    
    /// Fetches the categories from the network and returns a publisher.
    /// - Returns: A publisher that emits an array of `Categories` on success, or a `NetworkError` on failure.
    func fetchCategories() -> AnyPublisher<[Categories], NetworkError> {
        return networking.request(endpoint: AppEndPoint.getCategory)
            // Maps the response to an array of Categories, throwing an error if the response is invalid.
            .tryMap { (response: CategoryResponse) -> [Categories] in
                guard let items = response.categories else {
                    throw NetworkError.invalidResponse // Or a custom error
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

