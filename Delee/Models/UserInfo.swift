//
//  UserInfo.swift
//  Delee
//
//  Created by Шабнам Шарипова on 04/09/26.
//

import Foundation

struct UserInfo: Codable {
   var name: String
    let phone: String
    var email: String?
    var birthDate:Date?
    var gender:String?
    var wantsSMS:Bool
    var wantsEmail:Bool
    
    var addresses: [Address] = []
    var selectedAddressID:UUID?

}
