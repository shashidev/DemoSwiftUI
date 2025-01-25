//
//  NetworkManagerTests.swift
//  DummyAppTests
//

import XCTest
import Combine
@testable import DummyApp

final class NetworkManagerTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    private var networkManager: NetworkManager!
    private var sessionMock: URLSessionMock!

   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        cancellables = []
        sessionMock = URLSessionMock(data: nil, response: nil, error: nil)
        networkManager = NetworkManager(session: sessionMock)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
        networkManager = nil
        sessionMock = nil
        super.tearDown()
    }

    func testRequestWithValidResponse() {
        // Arrange
        let expectedData = "{\"strMeal\":\"Test Meal\"}".data(using: .utf8)!
        let url = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        sessionMock = URLSessionMock(data: expectedData, response: response, error: nil)
        networkManager = NetworkManager(session: sessionMock)

        struct MockResponse: Decodable {
            let strMeal: String
        }

        // Act & Assert
        let expectation = XCTestExpectation(description: "Valid response")
        networkManager.request(endpoint: MockEndpoint())
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { (response: MockResponse) in
                XCTAssertEqual(response.strMeal, "Test Meal", "Expected meal name to be 'Test Meal', but got '\(response.strMeal)'")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequestWithInvalidResponse() {
        // Arrange
        let expectedData = Data() // Empty data
        let url = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
        sessionMock = URLSessionMock(data: expectedData, response: response, error: nil)
        networkManager = NetworkManager(session: sessionMock)

        struct MockResponse: Decodable {
            let name: String
        }

        // Act & Assert
        let expectation = XCTestExpectation(description: "Invalid response")
        networkManager.request(endpoint: MockEndpoint())
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error, "Expected error to be non-nil, but it was nil.")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { (_: MockResponse) in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequestWithDecodingError() {
        // Arrange
        let invalidJSONData = "Invalid JSON".data(using: .utf8)!
        let url = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        sessionMock = URLSessionMock(data: invalidJSONData, response: response, error: nil)
        networkManager = NetworkManager(session: sessionMock)

        struct MockResponse: Decodable {
            let name: String
        }

        // Act & Assert
        let expectation = XCTestExpectation(description: "Decoding error")
        networkManager.request(endpoint: MockEndpoint())
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .decodingError, "Expected error to be .decodingError, but got \(error).")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { (_: MockResponse) in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequestWithNetworkError() {
        // Arrange
        let urlError = URLError(.notConnectedToInternet)
        sessionMock = URLSessionMock(data: nil, response: nil, error: urlError)
        networkManager = NetworkManager(session: sessionMock)

        struct MockResponse: Decodable {
            let name: String
        }

        // Act & Assert
        let expectation = XCTestExpectation(description: "Network error")
        networkManager.request(endpoint: MockEndpoint())
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .requestFailed(urlError), "Expected error to be .requestFailed with \(urlError), but got \(error).")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { (_: MockResponse) in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}

