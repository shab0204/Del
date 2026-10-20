//
//  Promo.swift
//  Delee
//
//  Created by Шабнам Шарипова on 08/10/26.
//

import Foundation

struct Promo:Identifiable,Codable{
    var id = UUID()
    let code:String
    let discount:Int
    let expiresAt:String
    var isActivated:Bool
    
}
