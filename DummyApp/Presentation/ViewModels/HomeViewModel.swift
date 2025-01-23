//
//  ItemListViewModel.swift
//  DummyApp
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var categories: [Categories] = []
    @Published var meals: [Meals] = []
    @Published var defaultCategory: String?
    private var cancellables = Set<AnyCancellable>()
    private let mealServiceFacade: MealServiceFacade

    init(mealServiceFacade: MealServiceFacade = MealServiceFacade()) {
        self.mealServiceFacade = mealServiceFacade
    }

    func loadItems() {
        mealServiceFacade.fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error loading items: \(error)")
                }
            }, receiveValue: { [weak self] categories in
                self?.setupCategories(with: categories)
            })
            .store(in: &cancellables)
    }

    func loadMeal(category: String) {
        mealServiceFacade.fetchMeals(for: category)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error loading meals: \(error)")
                    self.meals = []
                }
            }, receiveValue: { [weak self] meals in
                self?.meals = meals
            })
            .store(in: &cancellables)
    }

    func loadAllMeals() {
        mealServiceFacade.fetchAllMeals()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error loading all meals: \(error)")
                    self.meals = []
                }
            }, receiveValue: { [weak self] meals in
                self?.meals = meals
            })
            .store(in: &cancellables)
    }

    private func setupCategories(with categories: [Categories]) {
        let allCategory = Categories(strCategory: "All")
        var allCategories = [allCategory]
        allCategories.append(contentsOf: categories)
        self.categories = allCategories
        self.defaultCategory = "All"
        loadAllMeals()
    }
}

