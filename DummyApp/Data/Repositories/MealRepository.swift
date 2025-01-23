//
//  MealRepository.swift
//  DummyApp
//
//  Created by Shashi Kumar on 23/01/25.
//

import Foundation
import Combine

protocol MealRepository {
    func fetchMeal(for category: String) -> AnyPublisher<[Meals], NetworkError>
}

class MealRepositoryImpl: MealRepository {
    
    private var networking: NetworkService
    
    init(networking: NetworkService = NetworkManager()) {
        self.networking = networking
    }
    
    
    func fetchMeal(for category: String) -> AnyPublisher<[Meals], NetworkError> {
        return networking.request(endpoint: .search(category: category))
            .tryMap { (response: MealResponse) -> [Meals] in
                guard let items = response.meals else {
                    throw NetworkError.invalidResponse
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
