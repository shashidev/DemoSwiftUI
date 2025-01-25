//
//  NetworkError.swift
//  DummyApp
//

import Foundation

/// Enum representing possible network errors.
enum NetworkError: Error, Equatable {
    case badURL                   // Indicates an invalid URL.
    case invalidResponse          // Indicates an invalid HTTP response.
    case decodingError            // Indicates a failure in decoding the response.
    case requestFailed(Error)     // Represents a failed network request with the associated error.
    case unknown                  // Represents an unknown error.

    /// Compares two `NetworkError` values for equality.
    /// - Parameters:
    ///   - lhs: The first `NetworkError` instance.
    ///   - rhs: The second `NetworkError` instance.
    /// - Returns: A Boolean value indicating whether the two errors are equal.
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL),
             (.invalidResponse, .invalidResponse),
             (.decodingError, .decodingError),
             (.unknown, .unknown):
            return true
        case let (.requestFailed(lhsError), .requestFailed(rhsError)):
            // Compares the domain and code of the associated errors.
            return (lhsError as NSError).domain == (rhsError as NSError).domain &&
                   (lhsError as NSError).code == (rhsError as NSError).code
        default:
            return false
        }
    }
}



