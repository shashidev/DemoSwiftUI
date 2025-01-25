//
//  MockCategoryRepository.swift
//  DummyAppTests
//


import XCTest
import Combine
@testable import DummyApp

/// A mock implementation of the `CategoryRepository` used for testing purposes.
/// It allows controlling the results returned by the `fetchCategories` method,
/// making it useful for unit tests where different scenarios need to be simulated.
class MockCategoryRepository: CategoryRepository {
    
    var mockCategories: [Categories]?
    var mockError: NetworkError?

    /// Mocks the `fetchCategories` method.
    /// - Returns: A publisher that emits a list of categories or an error based on the mock setup.
    func fetchCategories() -> AnyPublisher<[Categories], NetworkError> {
        // If a mock error is provided, emit that error
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        // If mock categories are provided, emit those categories
        if let categories = mockCategories {
            return Just(categories)
                .setFailureType(to: NetworkError.self) // Set the failure type to NetworkError
                .eraseToAnyPublisher()
        }
        // If neither mock categories nor error are provided, return an unknown error
        return Fail(error: .unknown).eraseToAnyPublisher()
    }
}


