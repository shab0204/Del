//
//  DishStore.swift
//  Delee
//
//  Created by Шабнам Шарипова on 05/10/26.
//


import Foundation
import Combine

class DishStore: ObservableObject{
    
    @Published var dishes:[Dish] = []
    @Published var isLoading = false
    @Published var errorText: String?
    
    func loadAll() async {
        isLoading = true
        errorText = nil

        let categoryNames = ["Beef", "Chicken", "Dessert", "Seafood", "Vegetarian"]
        var result: [Dish] = []

        do {
            for name in categoryNames {
                let meals = try await MealAPI.fetchMeals(category: name)
                print("ЗАГРУЗИЛ \(name):", meals.count, "блюд")
                result.append(contentsOf: meals)
            }
            dishes = result
            print("ВСЕГО:", dishes.count )
        } catch {
            errorText = "Не удалось загрузить: \(error.localizedDescription)"
            print("ОШИБКА ЗАГРУЗКИ:", error)
        }

        isLoading = false
    }
    
}
