//
//  FetchMealUseCase.swift
//  DummyApp
//
//  Created by Shashi Kumar on 23/01/25.
//

import Foundation
import Combine

protocol FetchMealUseCase {
    func execute(category: String) -> AnyPublisher<[Meals], NetworkError>
}


class FetchMealUseCaseImpl: FetchMealUseCase {
    private let repository: MealRepository

    init(repository: MealRepository = MealRepositoryImpl()) {
        self.repository = repository
    }

    func execute(category: String) -> AnyPublisher<[Meals], NetworkError> {
        return repository.fetchMeal(for: category)
    }
}
