//
//  NetworkManager.swift
//  DummyApp
//

import Foundation
import Combine

/// A class responsible for managing network requests.
class NetworkManager: NetworkService {
    
    /// The URL session to be used for making network requests.
    private let session: URLSessionProtocol
    
    /// Initializes the NetworkManager with a URLSession.
    /// - Parameter session: A session conforming to `URLSessionProtocol`. Defaults to `URLSession.shared`.
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    /// Makes a network request and decodes the response into a specified type.
    /// - Parameter endpoint: The API endpoint containing request details.
    /// - Returns: A publisher emitting the decoded response or a `NetworkError`.
    func request<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> {
        
        guard let request = endpoint.urlRequest() else {
            print("Invalid URL request")
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        print("Request: \(request.url?.absoluteString ?? "No URL")")
        
        return session.publisher(for: request)
            .tryMap { output in
                // Ensure the response is a valid HTTP response with a status code in the 200-299 range.
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

