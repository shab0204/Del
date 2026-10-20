//
//  OrderSuccesView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 07/10/26.
//

import SwiftUI

struct OrderSuccesView:View {
    let order :Order
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 16){
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                           .font(.system(size: 80))
                           .foregroundStyle(.green)

                       Text("Ваш заказ принят")
                           .font(.title2)
                           .fontWeight(.bold)

//                       Text("Примерное время доставки 30 минут")
//                           .font(.subheadline)
//                           .foregroundStyle(.secondary)
            VStack(alignment: .leading,spacing: 12){
                Text("Детали заказа")
                       .font(.headline)

                   HStack {
                       Text("Сумма")
                           .foregroundStyle(.secondary)
                       Spacer()
                       Text("\(order.total) ₽")
                           .fontWeight(.semibold)
                   }

                   HStack {
                       Text("Адрес")
                           .foregroundStyle(.secondary)
                       Spacer()
                       Text(order.address)
                   }

                   HStack {
                       Text("Время")
                           .foregroundStyle(.secondary)
                       Spacer()
                       Text(order.deliveryTime)
                   }
               }
               .padding(16)
               .background(Color(.systemGray6))
               .clipShape(RoundedRectangle(cornerRadius: 16))
            

                       Spacer()

                       Button {
                           dismiss()
                           
                       } label: {
                           Text("Готово")
                               .fontWeight(.semibold)
                               .foregroundStyle(.white)
                               .frame(maxWidth: .infinity)
                               .padding(.vertical, 16)
                               .background(Color.accentOrange)
                               .clipShape(RoundedRectangle(cornerRadius: 12))
                       }
                       .buttonStyle(.plain)
        }
        .padding(16)
    }
}

#Preview {
    OrderSuccesView(order: Order(
        items: [],
        total: 445,
        date: Date(),
        address: "Некрасова 24",
        comment: "Позвонить за 5 минут",
        deliveryTime: "Как можно быстрее",
        leaveAtDoor: false,
        callMe: true
    ))    
}
