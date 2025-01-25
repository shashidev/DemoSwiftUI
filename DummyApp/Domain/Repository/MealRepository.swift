//
//  MealRepository.swift
//  DummyApp
//

import Foundation
import Combine

/// A protocol defining the contract for fetching meal data from a data source.
protocol MealRepository {
    
    /// Fetches meals for a specific category from the network or data source.
    /// - Parameter category: The category of meals to fetch.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func fetchMeal(for category: String) -> AnyPublisher<[Meals], NetworkError>
    
    /// Fetches all meals from the network or data source.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func fetchAllMeal() -> AnyPublisher<[Meals], NetworkError>
}

