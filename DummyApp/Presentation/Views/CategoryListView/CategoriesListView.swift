//
//  ContentView.swift
//  DummyApp
//

import SwiftUI

struct CategoriesListView: View {
    @StateObject var viewModel = CategoryListViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                CategoryRow(category: category)
            }
            .navigationTitle("Categories")
            .onAppear {
                viewModel.loadItems()
            }
        }
    }
}

// Preview
struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView(viewModel: CategoryListViewModel())
    }
}
