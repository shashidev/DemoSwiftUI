//
//  FetchCategoryUseCaseImplTests.swift
//  DummyAppTests
//


import XCTest
import Combine
@testable import DummyApp

final class FetchCategoryUseCaseImplTests: XCTestCase {
    
    private var mockRepository: MockCategoryRepository!
    private var useCase: FetchCategoryUseCaseImpl!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockRepository = MockCategoryRepository()
        useCase = FetchCategoryUseCaseImpl(repository: mockRepository)
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables = nil
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func test_execute_withValidCategories_shouldReturnCategories() {
        // Given
        let expectedCategories = [Categories(idCategory: "1", strCategory: "Category 1"), Categories(idCategory: "2", strCategory: "Category 2")]
        mockRepository.mockCategories = expectedCategories
        
        mockRepository.mockCategories = expectedCategories
        
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
            XCTAssertEqual(categories.first?.strCategory, "Category 1")
            XCTAssertEqual(categories.last?.strCategory, "Category 2")
        }).store(in: &cancellables)
    }
    
    func test_execute_withError_shouldReturnError() {
           // Given
           mockRepository.mockError = .invalidResponse

           // When
           let expectation = XCTestExpectation(description: "Fetch categories with error")
           useCase.execute()
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
}
