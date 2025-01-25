//
//  HomeViewModelTests.swift
//  DummyAppTests
//

import XCTest
import Combine
@testable import DummyApp

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mealServiceFacadeMock: MealServiceFacadeMock!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mealServiceFacadeMock = MealServiceFacadeMock()
        viewModel = HomeViewModel(mealServiceFacade: mealServiceFacadeMock)
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mealServiceFacadeMock = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadItems_Success() {
        // Arrange
        let categories = [Categories(strCategory: "Category1"), Categories(strCategory: "Category2")]
        mealServiceFacadeMock.fetchCategoriesResult = .success(categories)
        
        let expectation = XCTestExpectation(description: "Categories loaded successfully")
        
        // Act
        viewModel.$categories
            .dropFirst()
            .sink { loadedCategories in
                XCTAssertEqual(loadedCategories.count, 3, "Expected 3 categories, including 'All' and mock categories, but found \(loadedCategories.count).")
                XCTAssertEqual(loadedCategories[0].strCategory, "All", "Expected the first category to be 'All', but found \(String(describing: loadedCategories[0].strCategory)).")
                XCTAssertEqual(loadedCategories[1].strCategory, "Category1", "Expected the second category to be 'Category1', but found \(String(describing: loadedCategories[1].strCategory)).")
                XCTAssertEqual(loadedCategories[2].strCategory, "Category2", "Expected the third category to be 'Category2', but found \(String(describing: loadedCategories[2].strCategory)).")
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadItems()
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadItems_Failure() {
        // Arrange
        mealServiceFacadeMock.fetchCategoriesResult = .failure(.invalidResponse)
        
        let expectation = XCTestExpectation(description: "Error handled for categories fetch")
        
        // Act
        viewModel.loadItems()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // No categories should be loaded
            XCTAssertTrue(self.viewModel.categories.isEmpty, "Expected categories to be empty, but found \(self.viewModel.categories.count) categories.")
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadMeal_Success() {
        // Arrange
        let meals = [Meals(idMeal: "1", strMeal: "Meal1"), Meals(idMeal: "2", strMeal: "Meal2")]
        mealServiceFacadeMock.fetchMealsResult = .success(meals)
        
        let expectation = XCTestExpectation(description: "Meals loaded successfully")
        
        // Act
        viewModel.$meals
            .dropFirst()
            .sink { loadedMeals in
                XCTAssertEqual(loadedMeals.count, 2, "Expected 2 meals, but found \(loadedMeals.count) meals.")
                XCTAssertEqual(loadedMeals[0].strMeal, "Meal1", "First meal should be 'Meal1', but found \(String(describing: loadedMeals[0].strMeal)).")
                XCTAssertEqual(loadedMeals[1].strMeal, "Meal2", "Second meal should be 'Meal2', but found \(String(describing: loadedMeals[1].strMeal)).")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadMeal(category: "Category1")
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadMeal_Failure() {
        // Arrange
        mealServiceFacadeMock.fetchMealsResult = .failure(.invalidResponse)
        
        let expectation = XCTestExpectation(description: "Error handled for meal fetch")
        
        // Act
        viewModel.loadMeal(category: "Category1")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Meals should be an empty array
            XCTAssertTrue(self.viewModel.meals.isEmpty, "Expected meals to be empty, but found \(self.viewModel.meals.count) meal(s).")
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadAllMeals_Success() {
          // Arrange
          let meals = [Meals(idMeal: "1", strMeal: "Meal1"), Meals(idMeal: "2", strMeal: "Meal2")]
          mealServiceFacadeMock.fetchAllMealsResult = .success(meals)

          let expectation = XCTestExpectation(description: "All meals loaded successfully")

          // Act
          viewModel.$meals
              .dropFirst()
              .sink { loadedMeals in
                  XCTAssertEqual(loadedMeals.count, 2, "Expected 2 meals, but found \(loadedMeals.count) meals.")
                  XCTAssertEqual(loadedMeals[0].strMeal, "Meal1", "Expected the first meal to be 'Meal1', but got \(String(describing: loadedMeals[0].strMeal)).")
                  XCTAssertEqual(loadedMeals[1].strMeal, "Meal2", "Expected the second meal to be 'Meal2', but got \(String(describing: loadedMeals[1].strMeal)).")
                  expectation.fulfill()
              }
              .store(in: &cancellables)

          viewModel.loadAllMeals()

          // Assert
          wait(for: [expectation], timeout: 1.0)
      }
    
    func testLoadAllMeals_Failure() {
            // Arrange
            mealServiceFacadeMock.fetchAllMealsResult = .failure(.invalidResponse)

            let expectation = XCTestExpectation(description: "Error handled for all meal fetch")

            // Act
            viewModel.loadAllMeals()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Meals should be an empty array
                XCTAssertTrue(self.viewModel.meals.isEmpty, "Expected the meals list to be empty, but it contains \(self.viewModel.meals.count) items.")
                expectation.fulfill()
            }

            // Assert
            wait(for: [expectation], timeout: 1.0)
        }
    
}
