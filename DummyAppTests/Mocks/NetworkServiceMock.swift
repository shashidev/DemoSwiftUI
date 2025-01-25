//
//  NetworkServiceMock.swift
//  DummyAppTests
//

import Foundation
import Combine
@testable import DummyApp

/// A mock implementation of `NetworkService` for testing network requests, simulating responses or errors.
class NetworkServiceMock: NetworkService {

    var mockResponseData: Data?
    var mockError: NetworkError?

    /// Mocks a network request and returns a publisher with a simulated response or error.
    /// - Parameter endpoint: The API endpoint for the request.
    /// - Returns: A publisher emitting the decoded response or an error.
    func request<T>(endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> where T: Decodable {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }

        guard let data = mockResponseData else {
            return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
        }

        let decoder = JSONDecoder()
        do {
            let decodedObject = try decoder.decode(T.self, from: data)
            return Just(decodedObject)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.decodingError).eraseToAnyPublisher()
        }
    }
}


