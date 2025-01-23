//
//  CategoryDetailView.swift
//  DummyApp
//
//

import SwiftUI

struct CategoryDetailView: View {
    let category: Categories
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                CategoryDetailImageView(imageUrl: category.strCategoryThumb)
                
                Text(category.strCategory ?? "")
                    .font(.largeTitle)
                    .bold()
                
                Text(category.strCategoryDescription ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(category.strCategory ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: Categories.dummuCategory)
    }
}
