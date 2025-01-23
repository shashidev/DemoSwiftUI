//
//  NetworkManager.swift
//  DummyApp
//

import Foundation
import Combine


// Concrete implementation of NetworkService using Combine
//class NetworkManager: NetworkService {
//    private let session: URLSession
//    
//    init(session: URLSession = .shared) {
//        self.session = session
//    }
//    
//    func request<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> {
//        guard let request = endpoint.urlRequest() else {
//            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
//        }
//        
//        return session.dataTaskPublisher(for: request)
//            .map { $0.data }
//            .decode(type: T.self, decoder: JSONDecoder())
//            .mapError { error in
//                (error as? URLError) != nil ? NetworkError.requestFailed(error) : NetworkError.decodingError
//            }
//            .eraseToAnyPublisher()
//    }
//}

//class NetworkManager: NetworkService {
//    private let session: URLSession
//    
//    init(session: URLSession = .shared) {
//        self.session = session
//    }
//    
//    func request<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> {
//        guard let request = endpoint.urlRequest() else {
//            print("Invalid URL request")
//            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
//        }
//        
//        print("Making request to URL: \(request.url?.absoluteString ?? "Unknown URL")")
//        
//        return session.dataTaskPublisher(for: request)
//            .tryMap { output in
//                guard let response = output.response as? HTTPURLResponse,
//                      (200...299).contains(response.statusCode) else {
//                    throw NetworkError.invalidResponse
//                }
//                return output.data
//            }
//            .decode(type: T.self, decoder: JSONDecoder())
//            .mapError { error in
//                print("Network error: \(error)")
//                return (error as? URLError) != nil ? NetworkError.requestFailed(error) : NetworkError.decodingError
//            }
//            .eraseToAnyPublisher()
//    }
//}

class NetworkManager: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> {
        guard let request = endpoint.urlRequest() else {
            print("Invalid URL request")
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        print("Request: \(request.url?.absoluteString ?? "No URL")")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .retry(2)
            .mapError { error in
                print("Error: \(error)")
                return (error as? URLError) != nil ? NetworkError.requestFailed(error) : NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
}
