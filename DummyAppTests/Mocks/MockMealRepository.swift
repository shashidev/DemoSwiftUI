//
//  MockMealRepository.swift
//  DummyAppTests
//


import XCTest
import Combine
@testable import DummyApp

/// A mock implementation of `MealRepository` for testing, simulating meal fetching with mock data or errors.
class MockMealRepository: MealRepository {

    var mockMeals: [Meals]?
    var mockError: NetworkError?

    /// Mocks fetching meals for a category.
    /// - Parameter category: The category for which meals are fetched.
    /// - Returns: A publisher emitting meals or an error.
    func fetchMeal(for category: String) -> AnyPublisher<[Meals], NetworkError> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        if let meals = mockMeals {
            return Just(meals)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        return Fail(error: .unknown).eraseToAnyPublisher()
    }

    /// Mocks fetching all meals.
    /// - Returns: A publisher emitting all meals or an error.
    func fetchAllMeal() -> AnyPublisher<[Meals], NetworkError> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        if let meals = mockMeals {
            return Just(meals)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        return Fail(error: .unknown).eraseToAnyPublisher()
    }
}


