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
    private let fetchItemsUseCase: FetchCategoryUseCase
    private let fetchMealUseCase: FetchMealUseCase

    init(fetchItemsUseCase: FetchCategoryUseCase = FetchCategoryUseCaseImpl(), fetchMealUseCase: FetchMealUseCase = FetchMealUseCaseImpl()) {
        self.fetchItemsUseCase = fetchItemsUseCase
        self.fetchMealUseCase = fetchMealUseCase
    }

    func loadItems() {
        fetchItemsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error loading items: \(error)")
                }
            }, receiveValue: { [weak self] categories in
                self?.categories = categories
                if let defaultCategory = categories.first?.strCategory {
                    self?.defaultCategory = defaultCategory
                    self?.loadMeal(category: defaultCategory)
                }
            })
            .store(in: &cancellables)
    }
    
    func loadMeal(category: String) {
        fetchMealUseCase.execute(category: category)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error loading items: \(error)")
                    self.meals = []
                }
            }, receiveValue: { [weak self] meals in
                self?.meals = meals
            })
            .store(in: &cancellables)
    }
}

