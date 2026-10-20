//
//  ProfileRow.swift
//  Delee
//
//  Created by Шабнам Шарипова on 17/09/26.
//

import SwiftUI

struct ProfileRow:View {
    let icon:String
    let title:String
    let subtitle:String
    
    var body: some View {
        HStack(spacing:12){
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(.primary)
                .frame(width: 24)
            
            VStack (alignment: .leading,spacing:2){
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
            
        }
        .padding(16)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


#Preview {
    VStack(spacing: 12) {
            ProfileRow(icon: "mappin", title: "Мои адреса", subtitle: "Управление адресами")
            ProfileRow(icon: "bell", title: "Уведомления", subtitle: "Последние уведомления")
            ProfileRow(icon: "heart.fill", title: "Мои блюда", subtitle: "Ваши сохранённые блюда")
        
        }
        .padding(16)
}
