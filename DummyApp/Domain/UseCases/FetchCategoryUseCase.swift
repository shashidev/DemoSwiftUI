//
//  FetchItemsUseCase.swift
//  DummyApp
//

import Foundation
import Combine


protocol FetchCategoryUseCase {
    func execute() -> AnyPublisher<[Categories], NetworkError>
}


class FetchCategoryUseCaseImpl: FetchCategoryUseCase {
    private let repository: CategoryRepository

    init(repository: CategoryRepository = CategoryRepositoryImpl()) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Categories], NetworkError> {
        return repository.fetchCategories()
    }
}
