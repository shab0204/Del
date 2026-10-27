//
//  OrdersView .swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject private var orderStore:OrderStore
    @EnvironmentObject private var userStore:UserStore
    var myOrders: [Order]{
        guard let phone = userStore.currentUser?.phone else {return []}
        return orderStore.orders.filter {$0.userPhone == phone}
    }
    var body: some View {
        NavigationStack{
            Group{
                if myOrders.isEmpty{
                    VStack(spacing: 12){
                        Image(systemName: "list.bullet.rectangle")
                            .font(.system(size: 28))
                            .foregroundStyle(.accentOrange)
                            .frame(width: 64,height: 64)
                            .background(Color.accentOrange.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        Text("Заказов пока нет")
                            .font(.headline)
                    }
                }
        else{
        ScrollView{
    LazyVStack(spacing:12){
                            ForEach(myOrders){ order in
                                VStack(alignment: .leading, spacing:6){
                                    HStack{
                                        Text("Заказ №\(order.id.uuidString.prefix(6))")
                                            .font(.headline)
                                        Spacer()
    Text("\(order.total) ₽")
                .fontWeight(.semibold)
                                        
                                    }
        Text(order.address)
                                   
            .font(.subheadline)
                .foregroundStyle(.secondary)
                                    HStack{
                                        Text(order.date.formatted(date:.abbreviated,time: .shortened))
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Text("•")
                                        Text("\(order.items.count) позиций")
                                    }
               
        .font(.caption)
        .foregroundStyle(.secondary)
                                }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(16)
        .background(Color(.systemGray6))
    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
    .padding(16)
                    }
                }
                    
            }
            .navigationTitle("История заказов")
        }
    }
}
#Preview {
    OrdersView()
        .environmentObject(OrderStore())
        .environmentObject(UserStore())
       
}
