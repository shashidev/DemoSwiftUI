//
//  NetworkManager.swift
//  DummyApp
//

import Foundation
import Combine

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
