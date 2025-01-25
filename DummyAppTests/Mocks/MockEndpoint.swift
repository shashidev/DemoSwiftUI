//
//  MockEndpoint.swift
//  DummyAppTests
//
//  Created by Shashi Kumar on 25/01/25.
//

import XCTest
@testable import DummyApp

struct MockEndpoint: APIEndpoint {
    func urlRequest() -> URLRequest? {
        return URLRequest(url: URL(string: "https://example.com")!)
    }
}
