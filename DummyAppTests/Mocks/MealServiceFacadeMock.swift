//
//  MealServiceFacadeMock.swift
//  DummyAppTests
//

import XCTest
import Combine
@testable import DummyApp

/// A mock implementation of the `MealServiceFacade` used for testing purposes.
/// It allows controlling the results returned by the service methods, making it useful for unit tests.
class MealServiceFacadeMock: MealServiceFacade {
    
    var fetchCategoriesResult: Result<[Categories], NetworkError> = .success([])
    var fetchMealsResult: Result<[Meals], NetworkError> = .success([])
    var fetchAllMealsResult: Result<[Meals], NetworkError> = .success([])

    /// Mocks the `fetchCategories` method, returning the pre-defined result.
    /// - Returns: A publisher that emits the mock `fetchCategoriesResult`.
    override func fetchCategories() -> AnyPublisher<[Categories], NetworkError> {
        return fetchCategoriesResult.publisher.eraseToAnyPublisher()
    }

    /// Mocks the `fetchMeals(for:)` method, returning the pre-defined result.
    /// - Parameter category: The category for which meals are fetched.
    /// - Returns: A publisher that emits the mock `fetchMealsResult`.
    override func fetchMeals(for category: String) -> AnyPublisher<[Meals], NetworkError> {
        return fetchMealsResult.publisher.eraseToAnyPublisher()
    }

    /// Mocks the `fetchAllMeals` method, returning the pre-defined result.
    /// - Returns: A publisher that emits the mock `fetchAllMealsResult`.
    override func fetchAllMeals() -> AnyPublisher<[Meals], NetworkError> {
        return fetchAllMealsResult.publisher.eraseToAnyPublisher()
    }
}


