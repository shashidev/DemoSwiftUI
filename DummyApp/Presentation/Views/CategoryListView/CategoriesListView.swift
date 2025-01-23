//
//  ContentView.swift
//  DummyApp
//

import SwiftUI

struct CategoriesListView: View {
    
    @StateObject var viewModel = CategoryListViewModel()
    @State private var initHasRun: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.categories) { category in
                            CategoryItemView(category: category, selectedCategory: $viewModel.defaultCategory)
                                .onTapGesture {
                                    viewModel.defaultCategory = category.strCategory
                                    viewModel.loadMeal(category: category.strCategory ?? "")
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
                
                .onAppear {
                    if !initHasRun {
                        viewModel.loadItems()
                        initHasRun = true
                    }
                }
                
                if !viewModel.meals.isEmpty {
                    MealListView(meals: viewModel.meals)
                } else {
                    Text("No meals available.")
                    Spacer()
                }
            }
            .navigationTitle("Meals")
        }
    }
}

// Preview
struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView(viewModel: CategoryListViewModel())
    }
}
