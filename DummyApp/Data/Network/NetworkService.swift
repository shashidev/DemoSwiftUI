//
//  NetworkService.swift
//  DummyApp
//


import Combine

// Protocol to define the Network Service layer
protocol NetworkService {
    func request<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError>
}

