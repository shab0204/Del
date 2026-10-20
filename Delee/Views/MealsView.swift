//
//  MealsView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 02/10/26.
//

import SwiftUI

struct MealsView:View {
    let category:String
    
    @State private var meals:[Dish] = []
    @State private var isLoading = false
    @State private var errorText: String?
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private func loadMeals() async {
        isLoading = true
        errorText = nil

        do {
            meals = try await MealAPI.fetchMeals(category: category)
        } catch {
            errorText = "Не удалось загрузить: \(error.localizedDescription)"
            print("ОШИБКА:", error)
        }

        isLoading = false
    }
    var body: some View {
        Group {
               if isLoading {
                   ProgressView("Загрузка...")
               } else if let errorText {
                   VStack(spacing: 12) {
                       Text(errorText)
                           .multilineTextAlignment(.center)
                           .foregroundStyle(.secondary)

                       Button("Повторить") {
                           Task { await loadMeals() }
                       }
                   }
                   .padding(32)
               } else {
                   ScrollView {
                       LazyVGrid(columns: columns, spacing: 16) {
                           ForEach(meals) { meal in
                               VStack(spacing: 8) {

                                   AsyncImage(url: URL(string: meal.image)) { image in
                                       image
                                           .resizable()
                                           .scaledToFill()
                                   } placeholder: {
                                       ProgressView()
                                   }
                                   .frame(height: 140)
                                   .frame(maxWidth: .infinity)
                                   .clipped()
                                   .clipShape(RoundedRectangle(cornerRadius: 16))

                                   Text(meal.name)
                                       .font(.subheadline)
                                       .fontWeight(.semibold)
                                       .lineLimit(2)
                               }
                           }
                       }
                       .padding(16)
                   }
               }
           }
           .navigationTitle(category)
           .task {
               await loadMeals()
           }
    }
}


#Preview {
    MealsView(category: "Seafood")
}
