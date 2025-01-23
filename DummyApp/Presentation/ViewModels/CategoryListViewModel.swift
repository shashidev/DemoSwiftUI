//
//  ItemListViewModel.swift
//  DummyApp
//

import Combine
import Foundation

class CategoryListViewModel: ObservableObject {
    @Published var categories: [Categories] = []
    private var cancellables = Set<AnyCancellable>()
    private let fetchItemsUseCase: FetchItemsUseCase

    init(fetchItemsUseCase: FetchItemsUseCase = FetchItemsUseCaseImpl()) {
        self.fetchItemsUseCase = fetchItemsUseCase
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
            })
            .store(in: &cancellables)
    }
}

