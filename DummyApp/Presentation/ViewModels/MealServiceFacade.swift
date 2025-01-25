//
//  MealServiceFacade.swift
//  DummyApp
//

import Foundation
import Combine

/// A service facade that provides a simplified interface for fetching categories and meals,
/// leveraging the use cases for fetching categories and meals.
class MealServiceFacade {
    
    /// The use case responsible for fetching categories.
    private let fetchCategoryUseCase: FetchCategoryUseCase
    
    /// The use case responsible for fetching meals.
    private let fetchMealUseCase: FetchMealUseCase

    /// Initializes the `MealServiceFacade` with default or provided use cases for fetching categories and meals.
    /// - Parameters:
    ///   - fetchCategoryUseCase: The use case used to fetch categories (default is `FetchCategoryUseCaseImpl`).
    ///   - fetchMealUseCase: The use case used to fetch meals (default is `FetchMealUseCaseImpl`).
    init(fetchCategoryUseCase: FetchCategoryUseCase = FetchCategoryUseCaseImpl(),
         fetchMealUseCase: FetchMealUseCase = FetchMealUseCaseImpl()) {
        self.fetchCategoryUseCase = fetchCategoryUseCase
        self.fetchMealUseCase = fetchMealUseCase
    }

    /// Fetches categories by invoking the corresponding use case.
    /// - Returns: A publisher that emits an array of `Categories` on success, or a `NetworkError` on failure.
    func fetchCategories() -> AnyPublisher<[Categories], NetworkError> {
        return fetchCategoryUseCase.execute()
    }

    /// Fetches meals for a specific category by invoking the corresponding use case.
    /// - Parameter category: The category of meals to fetch.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func fetchMeals(for category: String) -> AnyPublisher<[Meals], NetworkError> {
        return fetchMealUseCase.execute(category: category)
    }

    /// Fetches all meals by invoking the corresponding use case.
    /// - Returns: A publisher that emits an array of `Meals` on success, or a `NetworkError` on failure.
    func fetchAllMeals() -> AnyPublisher<[Meals], NetworkError> {
        return fetchMealUseCase.execute()
    }
}

