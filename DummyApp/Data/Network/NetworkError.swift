//
//  NetworkError.swift
//  DummyApp
//

import Foundation

// Enum to represent possible network errors
enum NetworkError: Error, Equatable {
    case badURL
    case invalidResponse
    case decodingError
    case requestFailed(Error)
    case unknown

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL),
             (.invalidResponse, .invalidResponse),
             (.decodingError, .decodingError),
             (.unknown, .unknown):
            return true
        case let (.requestFailed(lhsError), .requestFailed(rhsError)):
            return (lhsError as NSError).domain == (rhsError as NSError).domain &&
                   (lhsError as NSError).code == (rhsError as NSError).code
        default:
            return false
        }
    }
}


