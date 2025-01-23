//
//  FetchMealUseCaseImplTests.swift
//  DummyAppTests
//

import XCTest
import Combine
@testable import DummyApp

final class FetchMealUseCaseImplTests: XCTestCase {
    
    private var mockRepository: MockMealRepository!
    private var useCase: FetchMealUseCaseImpl!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockRepository = MockMealRepository()
        useCase = FetchMealUseCaseImpl(repository: mockRepository)
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables = nil
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func test_executeWithCategory_withValidMeals_shouldReturnMeals() {
        // Given
        let expectedMeals = [Meals(idMeal: "1", strMeal: "Meal1",strCategory: "Category1"), Meals(idMeal: "2", strMeal: "Meal2", strCategory: "Category2")]
        mockRepository.mockMeals = expectedMeals
        
        // When
        let publisher = useCase.execute(category: "Category1")
        
        // Then
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { categories in
            XCTAssertEqual(categories.count, 2)
            XCTAssertEqual(categories.first?.strMeal, "Meal1")
            XCTAssertEqual(categories.last?.strMeal, "Meal2")
        }).store(in: &cancellables)
    }
    
    func test_executeWithCategory_withError_shouldReturnError() {
        // Given
        mockRepository.mockError = .invalidResponse
        
        // When
        let expectation = XCTestExpectation(description: "Fetch meals by category with error")
        useCase.execute(category: "TestCategory")
            .sink(receiveCompletion: { completion in
                // Then
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .invalidResponse)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success.")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_executeAllMeals_withValidMeals_shouldReturnMeals() {
        // Given
        let expectedMeals = [Meals(idMeal: "1", strMeal: "Meal1"), Meals(idMeal: "2", strMeal: "Meal2")]
        mockRepository.mockMeals = expectedMeals
        
        // When
        let publisher = useCase.execute()
        
        // Then
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { categories in
            XCTAssertEqual(categories.count, 2)
            XCTAssertEqual(categories.first?.strMeal, "Meal1")
            XCTAssertEqual(categories.last?.strMeal, "Meal2")
        }).store(in: &cancellables)
    }
    
    func test_executeAllMeals_withError_shouldReturnError() {
        // Given
        mockRepository.mockError = .requestFailed(URLError(.notConnectedToInternet))
        
        // When
        let expectation = XCTestExpectation(description: "Fetch all meals with error")
        useCase.execute()
            .sink(receiveCompletion: { completion in
                // Then
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .requestFailed(URLError(.notConnectedToInternet)))
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success.")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
