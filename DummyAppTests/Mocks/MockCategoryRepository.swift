//
//  MockCategoryRepository.swift
//  DummyAppTests
//


import XCTest
import Combine
@testable import DummyApp

class MockCategoryRepository: CategoryRepository {
    var mockCategories: [Categories]?
    var mockError: NetworkError?

    func fetchCategories() -> AnyPublisher<[Categories], NetworkError> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        if let categories = mockCategories {
            return Just(categories)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        return Fail(error: .unknown).eraseToAnyPublisher()
    }
}

