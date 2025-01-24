//
//  MealDetailView.swift
//  DummyApp
//

import SwiftUI

struct MealDetailView: View {
    let meal: Meals

    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                // Meal Image
                AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                .clipped()
                .cornerRadius(10)
                .padding(.horizontal)

                // Meal Details
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

                // Instructions
                VStack(alignment: .leading, spacing: 15) {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(meal.strInstructions ?? "")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationTitle(meal.strCategory ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}
