//
//  CartItem.swift
//  Delee
//
//  Created by Шабнам Шарипова on 12/09/26.
//

import Foundation

struct CartItem: Identifiable,Codable{
    var id = UUID()
    let dish:Dish
    let selection: [String:String]
    var quantity:Int
    let unitPrice:Int
    var totalPrice:Int{
        unitPrice * quantity
    }
}
