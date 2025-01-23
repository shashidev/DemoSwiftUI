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
             XCTAssertEqual(meals.count, 2)
             XCTAssertEqual(meals.first?.strMeal, "Meal 1")
             XCTAssertEqual(meals.last?.strMeal, "Meal 2")
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
             XCTAssertTrue(meals.isEmpty)
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
                XCTAssertEqual(error, NetworkError.invalidResponse)
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
            XCTAssertEqual(meals.count, 1)
            XCTAssertEqual(meals.first?.strMeal, "Meal 1")
        }).store(in: &cancellables)
    }

}
