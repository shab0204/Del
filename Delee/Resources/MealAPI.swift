//
//  MealAPI.swift
//  Delee
//
//  Created by Шабнам Шарипова on 02/10/26.
//

import Foundation

struct MealAPI{
    
    struct MealsResponse: Codable {
        var meals: [Dish]
    }

    
    static func fetchCategories() async throws -> [MealCategory]{
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(CategoriesResponse.self,from: data)
        return response.categories
    }
    
    static func fetchMeals(category:String) async throws -> [Dish]{
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)")!
        let (data,_) = try await URLSession.shared.data(from: url)
        var response = try JSONDecoder().decode(MealsResponse.self,from: data)
        for index in response.meals.indices{
            response.meals[index].category = category
        }
        return response.meals
    }
}
