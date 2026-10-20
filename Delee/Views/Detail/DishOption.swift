//
//  DishOption.swift
//  Delee
//
//  Created by Шабнам Шарипова on 09/09/26.
//

import Foundation

struct DishOption:Identifiable,Codable{
    var id : String{ title }
    let title:String
    let values : [OptionValue]
}

struct OptionValue: Identifiable,Codable{
    var id : String { title }
    let title: String
    let price:Int?
}
