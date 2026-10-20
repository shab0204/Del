//
//  AddAddressView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/10/26.
//

import SwiftUI

struct AddAddressView:View {
    
    @EnvironmentObject var userStore:UserStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
@State private var value = ""
    var isFormValid:Bool{
        !title.isEmpty && !value.isEmpty
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Новый адрес")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Новый адрес (Дом, Работа)",text: $title)
                .padding(16)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            TextField("Адрес", text:$value)
                .padding(16)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button{
                userStore.addAddress(title: title, value: value)
                dismiss()
            }label: {
                 Text("Добавить")
                    .fontWeight(.semibold )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,16)
                    .background(isFormValid ? Color.accentOrange : Color.accentOrange.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            .disabled(!isFormValid)
            
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    AddAddressView()
        .environmentObject(UserStore())
}
