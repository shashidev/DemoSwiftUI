//
//  HomeViewSnapshotTest.swift
//  DummyAppTests
//


import XCTest
import SnapshotTesting
import SwiftUI
@testable import DummyApp

final class HomeViewSnapshotTest: XCTestCase {
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        // Add any initial setup required before each test.
        // This is executed before each test method is invoked.
    }
    
    // MARK: - Test Cases
    
    /// Snapshot test for HomeView with meals data.
    func testHomeViewWithMeals() {
        let mockViewModel = createMockViewModel(
            categories: [
                Categories(idCategory: "1", strCategory: "Category 1"),
                Categories(idCategory: "2", strCategory: "Category 2")
            ],
            meals: [
                Meals(idMeal: "1", strMeal: "Beef Asad", strMealThumb: "https://www.themealdb.com/images/media/meals/pkopc31683207947.jpg"),
                Meals(idMeal: "2", strMeal: "Beef Lo Mein", strMealThumb: "https://www.themealdb.com/images/media/meals/1529444830.jpg")
            ]
        )
        
        // Run snapshot test for HomeView with meals
        runSnapshotTest(for: HomeView(viewModel: mockViewModel), testName: "HomeViewWithMeals")
    }
    
    /// Snapshot test for HomeView without meals data.
    func testHomeViewWithoutMeals() {
        let mockViewModel = createMockViewModel(
            categories: [
                Categories(idCategory: "1", strCategory: "Chicken"),
                Categories(idCategory: "2", strCategory: "Lamb")
            ],
            meals: [] // No meals
        )
        
        // Run snapshot test for HomeView without meals
        runSnapshotTest(for: HomeView(viewModel: mockViewModel), testName: "HomeViewWithoutMeals")
    }
    
    // MARK: - Helper Methods
    
    /// Creates a mock `HomeViewModel` with the provided categories and meals.
    /// - Parameters:
    ///   - categories: A list of `Categories` to populate the view model.
    ///   - meals: A list of `Meals` to populate the view model.
    /// - Returns: A `HomeViewModel` object initialized with the given data.
    private func createMockViewModel(categories: [Categories], meals: [Meals]) -> HomeViewModel {
        let viewModel = HomeViewModel()
        viewModel.categories = categories
        viewModel.meals = meals
        return viewModel
    }
    
    /// Runs a snapshot test for the given SwiftUI view.
    /// - Parameters:
    ///   - view: The SwiftUI view to be tested.
    ///   - testName: A descriptive name for the snapshot test.
    private func runSnapshotTest(for view: some View, testName: String) {
        // Wrap the view in a UIHostingController for snapshot testing
        let hostingController = UIHostingController(rootView: view)
        // Run the snapshot test and compare it to the reference image
        assertSnapshot(of: hostingController, as: .image, named: testName)
    }
}


