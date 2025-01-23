//
//  CategoryRow.swift
//  DummyApp
//
//

import SwiftUI

struct CategoryRow: View {
    let category: Categories
    
    var body: some View {
        NavigationLink(destination: CategoryDetailView(category: category)) {
            HStack(spacing: 16) {
                CategoryImageView(imageUrl: category.strCategoryThumb)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(category.strCategory ?? "")
                        .font(.headline)
                    Text(category.strCategoryDescription ?? "")
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}


//Preview
struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(category: Categories.dummuCategory)
    }
}



