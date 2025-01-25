//
//  CategoryRepository.swift
//  DummyApp
//

import Foundation
import Combine

/// A protocol defining the contract for fetching categories from a data source.
protocol CategoryRepository {
    
    /// Fetches the categories from the network or a data source.
    /// - Returns: A publisher that emits an array of `Categories` on success, or a `NetworkError` on failure.
    func fetchCategories() -> AnyPublisher<[Categories], NetworkError>
}

