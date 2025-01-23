//
//  MealRepository.swift
//  DummyApp
//

import Foundation
import Combine

protocol MealRepository {
    func fetchMeal(for category: String) -> AnyPublisher<[Meals], NetworkError>
    func fetchAllMeal() -> AnyPublisher<[Meals], NetworkError>
}
