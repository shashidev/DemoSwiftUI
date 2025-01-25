//
//  URLSessionMock.swift
//  DummyAppTests
//


import Foundation
import Combine
@testable import DummyApp


/// A mock implementation of `URLSessionProtocol` for testing purposes.
/// It simulates network requests by providing mock responses, data, and errors.
class URLSessionMock: URLSessionProtocol {
    
    private let data: Data?
    private let response: URLResponse?
    private let error: URLError?

    // MARK: - Initialization
    
    /// Initializes the mock session with optional data, response, and error.
    /// - Parameters:
    ///   - data: The mock data to return in the response.
    ///   - response: The mock response to return in the response.
    ///   - error: The mock error to return if a failure occurs.
    init(data: Data?, response: URLResponse?, error: URLError?) {
        self.data = data
        self.response = response
        self.error = error
    }

    // MARK: - Methods
    
    /// Simulates a network request, returning a publisher that emits the mock data, response, or error.
    /// - Parameter request: The `URLRequest` to be made.
    /// - Returns: A publisher that emits either the mock data and response or a failure with a URLError.
    func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        
        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    
        guard let data = data, let response = response as? HTTPURLResponse else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        
        guard (200...299).contains(response.statusCode) else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}




