//
//  Order.swift
//  Delee
//
//  Created by Шабнам Шарипова on 06/10/26.
//

import Foundation

struct Order:Identifiable,Codable{
    var id = UUID()
    let items:[CartItem]
    let total:Int
    let date:Date
    let address:String
    let comment:String
    let deliveryTime: String
    let leaveAtDoor: Bool
    let callMe: Bool
    
    let userPhone:String
}
