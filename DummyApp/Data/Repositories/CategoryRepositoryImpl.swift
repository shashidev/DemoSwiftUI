//
//  FoodItemRepository.swift
//  DummyApp
//


import Foundation
import Combine


class CategoryRepositoryImpl: CategoryRepository {
    
    private var networking: NetworkService
    
    init(networking: NetworkService = NetworkManager()) {
        self.networking = networking
    }
    
    
    func fetchCategories() -> AnyPublisher<[Categories], NetworkError> {
        return networking.request(endpoint: .getCategory)
            .tryMap { (response: CategoryResponse) -> [Categories] in
                guard let items = response.categories else {
                    throw NetworkError.invalidResponse // Or a custom error
                }
                return items
            }
            .mapError { error -> NetworkError in
                // Map any errors to your `NetworkError` type
                return error as? NetworkError ?? .unknown
            }
            .eraseToAnyPublisher()
    }

}
