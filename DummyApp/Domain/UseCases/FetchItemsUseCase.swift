//
//  FetchItemsUseCase.swift
//  DummyApp
//

import Foundation
import Combine


protocol FetchItemsUseCase {
    func execute() -> AnyPublisher<[Categories], NetworkError>
}


class FetchItemsUseCaseImpl: FetchItemsUseCase {
    private let repository: CategoryRepository

    init(repository: CategoryRepository = CategoryRepositoryImpl()) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Categories], NetworkError> {
        return repository.fetchItems()
    }
}
