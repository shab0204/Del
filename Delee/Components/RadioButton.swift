//
//  RadioButton.swift
//  Delee
//
//  Created by Шабнам Шарипова on 27/09/26.
//

import SwiftUI

struct RadioButton:View {
    let title:String
    let isSelected:Bool
    let action: () ->Void
    var body: some View {
        Button(action:action){
            HStack(spacing:8){
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundStyle( isSelected ? .accentOrange : .gray)
                Text(title)
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(16)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}
