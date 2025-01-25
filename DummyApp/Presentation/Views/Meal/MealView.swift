//
//  MealView.swift
//  DummyApp
//

import SwiftUI

struct MealView: View {
    let meal: Meals

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(meal.strMeal ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)

            HStack {
                Text("Category:")
                    .fontWeight(.semibold)
                Text(meal.strCategory ?? "")
                    .foregroundColor(.secondary)
            }

            HStack {
                Text("Area:")
                    .fontWeight(.semibold)
                Text(meal.strArea ?? "")
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}
