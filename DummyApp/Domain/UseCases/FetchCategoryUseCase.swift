//
//  FetchItemsUseCase.swift
//  DummyApp
//

import Foundation
import Combine


/// A protocol defining the contract for executing a use case to fetch categories.
protocol FetchCategoryUseCase {
    
    /// Executes the use case to fetch categories.
    /// - Returns: A publisher that emits an array of `Categories` on success, or a `NetworkError` on failure.
    func execute() -> AnyPublisher<[Categories], NetworkError>
}

/// A concrete implementation of `FetchCategoryUseCase` that fetches categories using a `CategoryRepository`.
class FetchCategoryUseCaseImpl: FetchCategoryUseCase {
    
    /// The repository used to fetch category data.
    private let repository: CategoryRepository

    /// Initializes the `FetchCategoryUseCaseImpl` with a default or provided category repository.
    /// - Parameter repository: The category repository used to fetch categories (default is `CategoryRepositoryImpl`).
    init(repository: CategoryRepository = CategoryRepositoryImpl()) {
        self.repository = repository
    }

    /// Executes the use case by fetching categories from the repository.
    /// - Returns: A publisher that emits an array of `Categories` on success, or a `NetworkError` on failure.
    func execute() -> AnyPublisher<[Categories], NetworkError> {
        return repository.fetchCategories()
    }
}

