//
//  CategoryImageView.swift
//  DummyApp
//
//

import SwiftUI

struct CategoryImageView: View {
    let imageUrl: String?
    
    var body: some View {
        if let urlString = imageUrl, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 50, height: 50)
                    ProgressView()
                }
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .foregroundColor(.gray)
        }
    }
}
