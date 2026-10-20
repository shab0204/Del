//
//  Promotion.swift
//  Delee
//
//  Created by Шабнам Шарипова on 11/10/26.
//

import Foundation

struct Promotion:Identifiable{
    let id = UUID()
    let title:String
    let description:String
    let imageURL:String
    let validUntil:String?
}
