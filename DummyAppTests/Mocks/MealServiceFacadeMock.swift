//
//  MealServiceFacadeMock.swift
//  DummyAppTests
//
//  Created by Shashi Kumar on 24/01/25.
//

import XCTest
import Combine
@testable import DummyApp

class MealServiceFacadeMock: MealServiceFacade {
    var fetchCategoriesResult: Result<[Categories], NetworkError> = .success([])
    var fetchMealsResult: Result<[Meals], NetworkError> = .success([])
    var fetchAllMealsResult: Result<[Meals], NetworkError> = .success([])

    override func fetchCategories() -> AnyPublisher<[Categories], NetworkError> {
        return fetchCategoriesResult.publisher.eraseToAnyPublisher()
    }

    override func fetchMeals(for category: String) -> AnyPublisher<[Meals], NetworkError> {
        return fetchMealsResult.publisher.eraseToAnyPublisher()
    }

    override func fetchAllMeals() -> AnyPublisher<[Meals], NetworkError> {
        return fetchAllMealsResult.publisher.eraseToAnyPublisher()
    }
}

