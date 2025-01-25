//
//  MealInstructionsView.swift
//  DummyApp
//


import SwiftUI

struct MealInstructionsView: View {
    let instructions: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Instructions")
                .font(.title2)
                .fontWeight(.semibold)

            Text(instructions ?? "")
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
