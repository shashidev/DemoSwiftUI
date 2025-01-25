//
//  CategoryRepositoryImplTests.swift
//  DummyAppTests
//

import XCTest
import Combine
@testable import DummyApp

final class CategoryRepositoryImplTests: XCTestCase {
    
    private var sut: CategoryRepositoryImpl!
    private var networkServiceMock: NetworkServiceMock!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        sut = CategoryRepositoryImpl(networking: networkServiceMock)
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkServiceMock = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_fetchCategories_withValidResponse_shouldReturnCategories() {
        // Given
        let mockData = """
        {
            "categories": [
                {
                    "idCategory": "1",
                    "strCategory": "Category 1"
                },
                {
                    "idCategory": "2",
                    "strCategory": "Category 2"
                }
            ]
        }
        """.data(using: .utf8)!
        
        
        networkServiceMock.mockResponseData = mockData
        
        // When
        let publisher = sut.fetchCategories()
        
        // Then
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { categories in
            XCTAssertEqual(categories.count, 2, "Expected 2 categories, but found \(categories.count) categories.")
            XCTAssertEqual(categories.first?.strCategory, "Category 1", "The first category should be 'Category 1', but got '\(categories.first?.strCategory ?? "nil")'.")
            XCTAssertEqual(categories.last?.strCategory, "Category 2", "The last category should be 'Category 2', but got '\(categories.last?.strCategory ?? "nil")'.")

        }).store(in: &cancellables)
    }
    
    func test_fetchCategories_withEmptyResponse_shouldReturnEmptyArray() {
         // Given
         let mockData = """
         {
             "categories": []
         }
         """.data(using: .utf8)!
         
        
         networkServiceMock.mockResponseData = mockData
         
         
         // When
        let publisher = sut.fetchCategories()
         
         // Then
         publisher.sink(receiveCompletion: { completion in
             switch completion {
             case .failure(let error):
                 XCTFail("Expected success, but got error: \(error)")
             case .finished:
                 break
             }
         }, receiveValue: { meals in
             XCTAssertTrue(meals.isEmpty, "Expected an empty categories array, but got \(meals.count) items.")
         }).store(in: &cancellables)
     }
    
}
