//
//  NetworkServiceMock.swift
//  DummyAppTests
//

import Foundation
import Combine
@testable import DummyApp

class NetworkServiceMock: NetworkService {
    var mockResponseData: Data?
    var mockError: NetworkError?
    
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

