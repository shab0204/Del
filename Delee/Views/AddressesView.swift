//
//  AddressesView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 30/09/26.
//

import SwiftUI

struct AddressesView:View {
    @EnvironmentObject var userStore : UserStore
    @Environment(\.dismiss) private var dismiss
    @State private var showAddAddress = false
    @State private var editingAddress : Address?
    var body: some View {
        VStack(spacing:0){
            
            HStack{
                Text("Мои адреса")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                
                Button("+ Новый адрес"){
                    showAddAddress = true
                }
                .font(.subheadline)
                .foregroundStyle(.accentOrange)
            }
            .padding(16)
            
            ScrollView{
                VStack(spacing:12){
                    
                    ForEach(userStore.currentUser?.addresses ?? []){
                        address in
                        HStack(spacing: 8){
                            RadioButton(
                                title: address.title, isSelected: userStore.currentUser?.selectedAddressID == address.id
                            ){
                                userStore.selectAddress(address)
                            }
                            Button{
                                editingAddress = address
                            }label: {
                                Image(systemName: "pencil")
                                    .foregroundStyle(.secondary)
                                    .padding(12)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal,16)
            }
            Button{
                dismiss()
            }label: {
                Text("Доставить сюда")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,16)
                    .background(Color.accentOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            .padding(16)
        }
        .sheet(isPresented: $showAddAddress){
            AddAddressView()
        }
        .sheet(item: $editingAddress){
           address in
            EditAddressView(address: address)
        }
    }
}


#Preview {
    let store = UserStore()
    store.login(name: "Шабнам", phone: "+992900000000")
    store.addAddress(title: "Дом", value: "Некрасова 24")
    store.addAddress(title: "Работа", value: "Рудаки 10")

    return AddressesView()
        .environmentObject(store)
}
