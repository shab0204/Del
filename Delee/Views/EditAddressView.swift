//
//  EditAddressView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 02/10/26.
//

import SwiftUI

struct EditAddressView:View {
    @EnvironmentObject var userStore : UserStore
    @Environment(\.dismiss) private var dismiss
    let address : Address
    @State private var title =  ""
    @State private var value = ""
    var body: some View {
        VStack(alignment:.leading,spacing: 16){
            Text("Редактировать адрес")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Название",text: $title)
                .padding(16)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            TextField("Адрес", text: $value)
                  .padding(16)
                  .background(Color(.systemGray6))
                  .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button{
                let update = Address(id : address.id,title:title, value: value)
                userStore.updateAddress(update)
                dismiss()
            }label: {
                Text("Сохранить")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,16)
                    .background(Color.accentOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            
            Button{
                userStore.removeAddress(address)
                dismiss()
            }label: {
                Text("Удалить адрес")
                    .fontWeight(.semibold)
                           .foregroundStyle(.red)
                           .frame(maxWidth: .infinity)
                           .padding(.vertical, 16)
                           .background(Color(.systemGray6))
                           .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            Spacer()
            
        }
        .padding(16)
        .onAppear{
            title = address.title
            value = address.value
        }
    }
}

#Preview {
    EditAddressView(address:Address(title: "Дом", value: "Некрасова 28"))
        .environmentObject(UserStore())
}
