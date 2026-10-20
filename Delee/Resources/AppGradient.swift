//
//  AppGradient.swift
//  Delee
//
//  Created by Шабнам Шарипова on 02/09/26.
//

import SwiftUI

extension LinearGradient {
    static let badgeBlue = LinearGradient(
        colors: [Color("BadgeBlueStart"), Color("BadgeBlueEnd")],
                       startPoint: .leading,
                       endPoint: .trailing
    )
}
