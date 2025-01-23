//
//  CategoryRepository.swift
//  DummyApp
//

import Foundation
import Combine

protocol CategoryRepository {
    func fetchCategories() -> AnyPublisher<[Categories], NetworkError>
}
