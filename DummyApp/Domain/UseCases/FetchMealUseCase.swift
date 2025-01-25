//
//  FetchMealUseCase.swift
//  DummyApp
//

import Foundation
import Combine

/// A protocol defining the contract for executing use cases to fetch meals.
protocol FetchMealUseCase {
    
    /// Executes the use case to fetch meals for a specific category.
    /// - Parameter category: The category of meals to fetch.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func execute(category: String) -> AnyPublisher<[Meals], NetworkError>
    
    /// Executes the use case to fetch all meals.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func execute() -> AnyPublisher<[Meals], NetworkError>
}

/// A concrete implementation of `FetchMealUseCase` that fetches meals using a `MealRepository`.
class FetchMealUseCaseImpl: FetchMealUseCase {
    
    /// The repository used to fetch meal data.
    private let repository: MealRepository

    /// Initializes the `FetchMealUseCaseImpl` with a default or provided meal repository.
    /// - Parameter repository: The meal repository used to fetch meals (default is `MealRepositoryImpl`).
    init(repository: MealRepository = MealRepositoryImpl()) {
        self.repository = repository
    }

    /// Executes the use case to fetch meals for a specific category.
    /// - Parameter category: The category of meals to fetch.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func execute(category: String) -> AnyPublisher<[Meals], NetworkError> {
        return repository.fetchMeal(for: category)
    }
    
    /// Executes the use case to fetch all meals.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func execute() -> AnyPublisher<[Meals], NetworkError> {
        return repository.fetchAllMeal()
    }
}


