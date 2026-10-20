//
//  PromotionStore.swift
//  Delee
//
//  Created by Шабнам Шарипова on 12/10/26.
//

import Foundation
import Combine

class PromotionStore:ObservableObject {
    @Published var promotions: [Promotion] = []
    func build(from dishes:[Dish]){
        promotions = dishes
            .filter{$0.hasDiscount}
            .prefix(10)
            .map{dish in
                Promotion( title: dish.name,
                           description: "Попробуйте \(dish.name) из категории \(dish.category) по специальной цене",
                           imageURL: dish.image,
                           validUntil: "по 30 апреля")
            }
        
    }
    
}
