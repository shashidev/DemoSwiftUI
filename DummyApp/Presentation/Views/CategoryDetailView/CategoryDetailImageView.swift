//
//  CategoryDetailImageView.swift
//  DummyApp
//
//

import SwiftUI

struct CategoryDetailImageView: View {
    let imageUrl: String?
    
    var body: some View {
        if let urlString = imageUrl, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.1))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    ProgressView()
                }
            }
            .frame(height: 200)
        }else {
            // Handle the case where the URL is invalid or nil
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(Circle())
                .foregroundColor(.gray)
        }
    }
}


