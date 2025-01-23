//
//  MockMealRepository.swift
//  DummyAppTests
//
//  Created by Shashi Kumar on 24/01/25.
//

import XCTest
import Combine
@testable import DummyApp

class MockMealRepository: MealRepository {
    var mockMeals: [Meals]?
    var mockError: NetworkError?

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

