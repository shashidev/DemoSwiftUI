//
//  CategoryImageView.swift
//  DummyApp
//
//

import SwiftUI

struct MealImageView: View {
    let imageUrl: String?
    @State private var cachedImage: UIImage? = nil

    var body: some View {
        if let cachedImage {
            Image(uiImage: cachedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        } else if let urlString = imageUrl, let url = URL(string: urlString) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 50, height: 50)
                ProgressView()
            }
            .onAppear {
                loadImage(from: url)
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
    
    private func loadImage(from url: URL) {
        // Check if the image is already cached
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: url.absoluteString) {
            self.cachedImage = cachedImage
            return
        }
        
        // Download the image and cache it
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            // Cache the image
            ImageCacheManager.shared.cacheImage(image, forKey: url.absoluteString)
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.cachedImage = image
            }
        }
        .resume()
    }
}

