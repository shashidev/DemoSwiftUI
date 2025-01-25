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
                MealImageView(imageURL: meal.strMealThumb)
                MealView(meal: meal)
                MealInstructionsView(instructions: meal.strInstructions)
                Spacer()
            }
        }
        .navigationTitle(meal.strCategory ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}


//// Preview
struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        MealDetailView(meal: Meals.previewMeal)
    }
}



