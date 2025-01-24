//
//  MealDetailViewSnapshotTests.swift
//  DummyAppTests
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import DummyApp

class MealDetailViewSnapshotTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Add any initial setup required before each test.
        // This method is called before each test method in the class is invoked.
    }

    func testMealDetailView() {
        // Step 1: Create a mock Meals object with sample data for testing
        let mockMeal = Meals(idMeal: "1", strMeal: "Beef Asad", strCategory: "Main Course", strArea: "American", strInstructions: "1. Cook the beef. 2. Prepare the sauce. 3. Serve the meal.", strMealThumb: "https://www.themealdb.com/images/media/meals/pkopc31683207947.jpg")

        // Step 2: Initialize the MealDetailView with the mock data
        let mealDetailView = MealDetailView(meal: mockMeal)

        // Step 3: Wrap the MealDetailView inside a UIHostingController to enable snapshot testing
        let hostingController = UIHostingController(rootView: mealDetailView)

        // Step 4: Take a snapshot of the hosting controller and compare it to the reference image
        assertSnapshot(of: hostingController, as: .image, named: "mealDetailViewWithMeal")
    }

    func testMealDetailViewEmpty() {
        // Step 1: Create a mock Meals object with empty data for testing empty state
        let mockMeal = Meals(idMeal: "1", strMeal: "", strCategory: "", strArea: "", strInstructions: "", strMealThumb: "")

        // Step 2: Initialize the MealDetailView with the mock data (empty state)
        let mealDetailView = MealDetailView(meal: mockMeal)

        // Step 3: Wrap the MealDetailView inside a UIHostingController for snapshot testing
        let hostingController = UIHostingController(rootView: mealDetailView)

        // Step 4: Take a snapshot of the hosting controller and compare it to the reference image for the empty state
        assertSnapshot(of: hostingController, as: .image, named: "mealDetailViewEmpty")
    }

}


