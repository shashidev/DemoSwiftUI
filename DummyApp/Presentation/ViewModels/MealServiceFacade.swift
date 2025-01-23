//
//  MealServiceFacade.swift
//  DummyApp
//

import Foundation
import Combine

class MealServiceFacade {
    private let fetchCategoryUseCase: FetchCategoryUseCase
    private let fetchMealUseCase: FetchMealUseCase

    init(fetchCategoryUseCase: FetchCategoryUseCase = FetchCategoryUseCaseImpl(),
         fetchMealUseCase: FetchMealUseCase = FetchMealUseCaseImpl()) {
        self.fetchCategoryUseCase = fetchCategoryUseCase
        self.fetchMealUseCase = fetchMealUseCase
    }

    func fetchCategories() -> AnyPublisher<[Categories], NetworkError> {
        return fetchCategoryUseCase.execute()
    }

    func fetchMeals(for category: String) -> AnyPublisher<[Meals], NetworkError> {
        return fetchMealUseCase.execute(category: category)
    }

    func fetchAllMeals() -> AnyPublisher<[Meals], NetworkError> {
        return fetchMealUseCase.execute()
    }
}
