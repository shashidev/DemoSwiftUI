//
//  URLSessionMock.swift
//  DummyAppTests
//


import Foundation
import Combine
@testable import DummyApp


class URLSessionMock: URLSessionProtocol {
    private let data: Data?
    private let response: URLResponse?
    private let error: URLError?

    init(data: Data?, response: URLResponse?, error: URLError?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let data = data, let response = response as? HTTPURLResponse else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        
        // Simulate HTTP status code check
        guard (200...299).contains(response.statusCode) else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}



