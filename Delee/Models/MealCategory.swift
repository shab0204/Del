//
//  MealCategory.swift
//  Delee
//
//  Created by Шабнам Шарипова on 05/10/26.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [MealCategory]
}

struct MealCategory: Codable, Identifiable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String

    var id: String { idCategory }
}
