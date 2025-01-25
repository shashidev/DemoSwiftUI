//
//  MealRepositoryImplTests.swift
//  DummyAppTests
//

import XCTest
import Combine
@testable import DummyApp

final class MealRepositoryImplTests: XCTestCase {
    
    var sut:MealRepositoryImpl!
    var networkServiceMock: NetworkServiceMock!
    var cancellables: Set<AnyCancellable>!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        sut = MealRepositoryImpl(networking: networkServiceMock)
        cancellables = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkServiceMock = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchMeal_withValidCategory_shouldReturnMeals() {
         // Given
         let mockData = """
         {
             "meals": [
                 {
                     "idMeal": "1",
                     "strMeal": "Meal 1"
                 },
                 {
                     "idMeal": "2",
                     "strMeal": "Meal 2"
                 }
             ]
         }
         """.data(using: .utf8)!
         
        
         networkServiceMock.mockResponseData = mockData
         
         // When
        let publisher = sut.fetchMeal(for: "All")
         
         // Then
         publisher.sink(receiveCompletion: { completion in
             switch completion {
             case .failure(let error):
                 XCTFail("Expected success, but got error: \(error)")
             case .finished:
                 break
             }
         }, receiveValue: { meals in
             XCTAssertEqual(meals.count, 2, "Expected 2 meals, but found \(meals.count).")
             XCTAssertEqual(meals.first?.strMeal, "Meal 1", "The first meal should be 'Meal 1', but found \(meals.first?.strMeal ?? "nil").")
             XCTAssertEqual(meals.last?.strMeal, "Meal 2", "The last meal should be 'Meal 2', but found \(meals.last?.strMeal ?? "nil").")

         }).store(in: &cancellables)
     }
    
    func test_fetchMeal_withEmptyResponse_shouldReturnEmptyArray() {
         // Given
         let mockData = """
         {
             "meals": []
         }
         """.data(using: .utf8)!
         
        
         networkServiceMock.mockResponseData = mockData
         
         
         // When
        let publisher = sut.fetchMeal(for: "All")
         
         // Then
         publisher.sink(receiveCompletion: { completion in
             switch completion {
             case .failure(let error):
                 XCTFail("Expected success, but got error: \(error)")
             case .finished:
                 break
             }
         }, receiveValue: { meals in
             XCTAssertTrue(meals.isEmpty, "Expected meals to be empty, but it contains \(meals.count) items.")
         }).store(in: &cancellables)
     }
    
    func test_fetchMeal_withInvalidResponse_shouldReturnError() {
        // Given
        networkServiceMock.mockError = NetworkError.invalidResponse
        
        // When
        let publisher = sut.fetchMeal(for: "All")
        
        // Then
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.invalidResponse, "Expected error to be .invalidResponse, but got \(error).")
            case .finished:
                XCTFail("Expected failure, but got finished.")
            }
        }, receiveValue: { meals in
            XCTFail("Expected failure, but got value: \(meals)")
        }).store(in: &cancellables)
    }
    
    func test_fetchAllMeal_shouldReturnMeals() {
        // Given
        let mockData = """
            {
                "meals": [
                    {
                        "idMeal": "1",
                        "strMeal": "Meal 1"
                    }
                ]
            }
            
            """.data(using: .utf8)!
        
        networkServiceMock.mockResponseData = mockData
        
        // When
        let publisher = sut.fetchAllMeal()
        
        // Then
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { meals in
            XCTAssertEqual(meals.count, 1, "Expected 1 meal, but found \(meals.count) meals.")
            XCTAssertEqual(meals.first?.strMeal, "Meal 1", "Expected the first meal to be 'Meal 1', but got \(meals.first?.strMeal ?? "nil").")
        }).store(in: &cancellables)
    }

}
