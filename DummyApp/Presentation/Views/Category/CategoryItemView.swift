//
//  CategoryItemView.swift
//  DummyApp
//

import SwiftUI

struct CategoryItemView: View {
    var category: Categories
    @Binding var selectedCategory: String?

    var body: some View {
        Text(category.strCategory ?? "")
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(selectedCategory == category.strCategory ? Color.blue : Color.gray.opacity(0.2))
            .foregroundColor(selectedCategory == category.strCategory ? .white : .black)
            .cornerRadius(10)
    }
}


//// Preview
struct CategoriesItemView_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedCategory: String? = "Dessert"
        CategoryItemView(category: Categories.dummuCategory, selectedCategory: $selectedCategory)
    }
}
