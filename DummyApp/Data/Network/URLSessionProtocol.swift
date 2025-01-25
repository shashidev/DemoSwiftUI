//
//  URLSessionProtocol.swift
//  DummyApp
//

import Foundation
import Combine

/// Protocol to abstract `URLSession` for easier testing and mocking.
protocol URLSessionProtocol {
    /// Publishes the result of a URL request, including response data and metadata.
    /// - Parameter request: The `URLRequest` to be executed.
    /// - Returns: A publisher emitting a tuple of `Data` and `URLResponse`, or a `URLError` if the request fails.
    func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

/// Extension to make `URLSession` conform to `URLSessionProtocol`.
extension URLSession: URLSessionProtocol {
    /// Publishes the result of a URL request using `URLSession`'s `dataTaskPublisher`.
    /// - Parameter request: The `URLRequest` to be executed.
    /// - Returns: A publisher emitting a tuple of `Data` and `URLResponse`, or a `URLError` if the request fails.
    func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return self.dataTaskPublisher(for: request)
            .mapError { $0 as URLError }
            .eraseToAnyPublisher()       
    }
}

