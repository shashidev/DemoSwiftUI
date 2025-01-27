//
//  ContentView.swift
//  DummyApp
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State private var hasInitialized = false

    var body: some View {
        NavigationView {
            VStack {
                categoryScrollView
                    .onAppear(perform: initializeView)
                
                if viewModel.isloading {
                    ProgressView("Loading meals...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !viewModel.meals.isEmpty {
                    MealListView(meals: viewModel.meals)
                } else {
                    emptyStateView
                }
            }
            .navigationTitle("Home")
        }
    }

    private var categoryScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.categories) { category in
                    CategoryItemView(category: category, selectedCategory: $viewModel.defaultCategory)
                        .onTapGesture {
                            handleCategorySelection(for: category)
                        }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text("No meals available.")
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }



    private func initializeView() {
        guard !hasInitialized else { return }
        viewModel.loadCategories()
        hasInitialized = true
    }

    private func handleCategorySelection(for category: Categories) {
        viewModel.defaultCategory = category.strCategory ?? ""
        viewModel.loadMeal(category: category.strCategory ?? "")
    }
}


//// Preview
struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
