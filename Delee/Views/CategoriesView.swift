//
//  CategoriesView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 02/10/26.
//

import SwiftUI

struct CategoriesView:View {
    @State private var categories: [MealCategory]  = []
    @State private var isLoading = false
    @State private var errorText:String?
    private func loadCategories() async{
        isLoading = true
        errorText = nil
        
        do {
            categories = try await MealAPI.fetchCategories()
            }
        catch{
            errorText = "Не удалось загрузить: \(error.localizedDescription)"
            print("ОШИБКА:", error)
        }
        isLoading = false
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
 
            NavigationStack {
                Group {
                    if isLoading {
                        ProgressView("Загрузка...")
                    } else if let errorText {
                        errorBlock(errorText)
                    } else {
                        categoriesGrid
                    }
                }
                .navigationTitle("Категории")
            }
            .task {
                await loadCategories()
            }
        }
    
    
    private var categoriesGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(categories) { category in
                    categoryCard(category)
                }
            }
            .padding(16)
        }
    }

    private func categoryCard(_ category:MealCategory) -> some View {
        NavigationLink {
            MealsView(category: category.strCategory)
        } label: {
            VStack(spacing: 8) {
                AsyncImage(url: URL(string: category.strCategoryThumb)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)

                Text(category.strCategory)
                    .font(.headline)
            }
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }

    private func errorBlock(_ text: String) -> some View {
        VStack(spacing: 12) {
            Text(text)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Повторить") {
                Task { await loadCategories() }
            }
        }
        .padding(32)
    }
       
}



#Preview {
    CategoriesView()
}
