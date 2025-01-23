//
//  MealListView.swift
//  DummyApp
//
//  Created by Shashi Kumar on 23/01/25.
//

import SwiftUI

struct MealListView: View {
    var meals: [Meals]
    
    var body: some View {
        List(meals) { meal in
            NavigationLink(destination: MealDetailView(meal: meal)) {
                CategoryImageView(imageUrl: meal.strMealThumb)
                Text(meal.strMeal ?? "")
                    .padding()
            }
        }
    }
}
