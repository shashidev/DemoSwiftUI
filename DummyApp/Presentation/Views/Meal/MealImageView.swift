//
//  MealImageView.swift
//  DummyApp
//

import SwiftUI

struct MealImageView: View {
    let imageURL: String?

    var body: some View {
        AsyncImage(url: URL(string: imageURL ?? "")) { image in
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
    }
}
