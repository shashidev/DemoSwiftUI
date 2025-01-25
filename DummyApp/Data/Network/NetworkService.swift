//
//  NetworkService.swift
//  DummyApp
//


import Combine

/// Protocol defining the responsibilities of a network service layer.
protocol NetworkService {
    /// Makes a network request and decodes the response into a specified type.
    /// - Parameter endpoint: The API endpoint containing request details.
    /// - Returns: A publisher emitting the decoded response or a `NetworkError`.
    func request<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError>
}


