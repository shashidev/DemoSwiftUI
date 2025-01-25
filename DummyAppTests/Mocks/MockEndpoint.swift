//
//  MockEndpoint.swift
//  DummyAppTests
//

import XCTest
@testable import DummyApp

/// A mock implementation of the `APIEndpoint` protocol, used for testing purposes.
/// It provides a mock URL request for simulating API calls in unit tests.
struct MockEndpoint: APIEndpoint {
    
    /// Mocks the `urlRequest` method to return a predefined URL request.
    /// - Returns: A `URLRequest` with a mock URL (`https://example.com`).
    func urlRequest() -> URLRequest? {
        return URLRequest(url: URL(string: "https://example.com")!)
    }
}

