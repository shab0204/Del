//
//  Address.swift
//  Delee
//
//  Created by Шабнам Шарипова on 28/09/26.
//

import Foundation

struct Address:Identifiable,Codable{
    var id = UUID()
    var title:String
    var value:String
}
