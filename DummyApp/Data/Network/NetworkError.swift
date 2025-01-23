//
//  NetworkError.swift
//  DummyApp
//

import Foundation

// Enum to represent possible network errors
enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case serverError(Int) // 4xx, 5xx
    case decodingError
    case invalidResponse
    case unknown
}

