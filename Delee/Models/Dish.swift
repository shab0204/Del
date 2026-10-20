//
//  Dish.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import Foundation

struct Dish:Identifiable,Codable{
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    var category: String = ""
    var id: String {idMeal}
   var description: String {
       "Вкусное блюдо из категории \(category)"
   }
    
    var name: String {strMeal}
    var image: String { strMealThumb }
    
    var price :Int{
        let digits = idMeal.compactMap{$0.wholeNumberValue}
        let sum = digits.reduce(0, + )
        return (sum % 400) + 200
    }
    

    
    var hasDiscount: Bool{
        price % 3 == 0
    }
    
    var oldPrice: Int?{
        hasDiscount ? price + 100 : nil
    }
    
    var discountPercent:Int?{
        guard let oldPrice else { return nil}
        return Int(Double(oldPrice - price) / Double(oldPrice) * 100)
    }
    
    var options:[DishOption]{
        [
        DishOption(title: "Порция", values: [OptionValue(title: "Стандарт", price: price),
                                            OptionValue(title: "Большая", price: price + 150)
                                            ]
                  )
        ]
    }
    
    enum CodingKeys: String, CodingKey {
          case idMeal
          case strMeal
          case strMealThumb
      }
    
}
