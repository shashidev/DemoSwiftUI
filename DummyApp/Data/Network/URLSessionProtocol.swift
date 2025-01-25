//
//  URLSessionProtocol.swift
//  DummyApp
//

import Foundation
import Combine

protocol URLSessionProtocol {
    func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}


extension URLSession: URLSessionProtocol {
    func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return self.dataTaskPublisher(for: request).mapError { $0 as URLError }.eraseToAnyPublisher()
    }
}
