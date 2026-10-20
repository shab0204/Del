//
//  CheckoutView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 06/10/26.
//

import SwiftUI

struct CheckoutView:View {
    @EnvironmentObject var cartStore: CartStore
    @EnvironmentObject var orderStore: OrderStore
    @EnvironmentObject var userStore: UserStore
    @Environment(\.dismiss) private var dismiss
    
    
    @State private var comment = ""
    @State private var showSuccess = false
    @State private var deliveryTime = "Как можно быстрее"
    @State private var leaveAtDoor = false
    @State private var callMe = false
    @State private var showAddress = false
    @State private var lastOrder:Order?
    var selectedAddress:Address?{
        guard let user = userStore.currentUser,
              let id = user.selectedAddressID else{return nil}
        return user.addresses.first {$0.id == id}
    }
    private func confirmOrder(){
        let order = Order(
            items: cartStore.items, total: cartStore.totalPrice, date: Date(), address: selectedAddress?.value ?? "Адрес не указан", comment: comment,  deliveryTime: deliveryTime,
            leaveAtDoor: leaveAtDoor,
            callMe: callMe
        )
        orderStore.add(order)
        cartStore.clear()
        lastOrder = order  

    }
    var body: some View {
        ScrollView{
            VStack(alignment: .leading,spacing: 16){
                Text("Куда доставить")
                    .font(.title3)
                    .fontWeight(.bold)
                Button {
                    showAddress = true
                } label: {
                    HStack(spacing: 12) {

                        Image(systemName: "mappin")
                            .foregroundStyle(.primary)

                        VStack(alignment: .leading, spacing: 4) {
                            if let address = selectedAddress {
                                Text(address.title)
                                    .font(.headline)
                                Text(address.value)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            } else {
                                Text("Адрес доставки")
                                    .font(.headline)
                                Text("Выберите адрес")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
//                else{
//                    Text("Адрес не выбран")
//                        .foregroundStyle(.secondary)
//                        .frame(maxWidth: .infinity,alignment: .leading)
//                        .padding(16)
//                        .background(Color(.systemGray6))
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                }
                Text("Комментарий курьеру")
                    .font(.headline)
                    .padding(.top,8)
                
                TextField("Напишите чего не хватает", text: $comment,axis: .vertical)
                    .lineLimit(3,reservesSpace: true)
                    .padding(16)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                Toggle("Оставить у двери",isOn: $leaveAtDoor)
                    .padding(16)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .tint(.accentOrange)
                Toggle("Позвонить мне", isOn: $callMe)
                    .padding(16)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .tint(.accentOrange)
                Text("Во сколько доставить")
                    .font(.headline)
                    .padding(.top, 8)

                Picker("Во сколько доставить", selection: $deliveryTime){
                    Text("Как можно быстрее").tag("Как можно быстрее")
                    Text("Ко времени").tag("Ко времени")
                }
                .pickerStyle(.segmented)
                .tint(.accentOrange)
                Spacer()
                Button {
                    confirmOrder()
                } label: {
                    Text("Подтвердить заказ")
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
        .sheet(isPresented: $showAddress){
            AddressesView()
        }
        .sheet(item: $lastOrder, onDismiss: { dismiss() }) { order in
            OrderSuccesView(order: order)
        }
    }
}
#Preview {
    CheckoutView()
        .environmentObject(CartStore())
        .environmentObject(OrderStore())
        .environmentObject(UserStore())
}
