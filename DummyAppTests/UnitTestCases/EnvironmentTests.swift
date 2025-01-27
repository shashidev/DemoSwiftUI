//
//  EnvironmentTests.swift
//  DummyAppTests
//
//  Created by Shashi Kumar on 27/01/25.
//

import XCTest
@testable import DummyApp

final class EnvironmentTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBaseURL() {
        let baseURL = AppEndPoint.currentBaseURL
        #if DEBUG
        XCTAssertEqual(baseURL.absoluteString, "https://www.themealdb.com/api/json/v1/1/")
        #elseif TEST
        XCTAssertEqual(baseURL.absoluteString, "https://api.example.com")
        #else
        XCTAssertEqual(baseURL.absoluteString, "https://api.example.com")
        #endif
    }
    
}
