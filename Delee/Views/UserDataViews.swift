//
//  UserDataViews.swift
//  Delee
//
//  Created by Шабнам Шарипова on 27/09/26.
//

import SwiftUI

struct UserDataViews:View {
    @EnvironmentObject var userStore:UserStore
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var birthDate = Date()
    @State private var gender = "female"
    @State private var phone = ""
    @State private var email = ""
    @State private var wantsSMS = false
    @State private var wantsEmail = false
    
    private func saveChanges(){
        userStore.updateProfile(
            name:name,
            birthDate: birthDate,
                    gender: gender,
                    phone: phone,
                    email: email,
                    wantsSMS: wantsSMS,
                    wantsEmail: wantsEmail
        )
        dismiss()
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing:16){
                Text("Личная информация")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Для получения персональных скидок и акций укажите свой пол и возраст")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                TextField("Как вас зовут", text: $name)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
   DatePicker("Дата рождения",
              selection:$birthDate,
              in: ...Date(),
              displayedComponents: .date
              )
   .padding(16)
       .background(Color(.systemGray6))
       .clipShape(RoundedRectangle(cornerRadius: 12))
       .tint(.accentOrange)
                HStack(spacing:12){
                    RadioButton(title: "Женщина", isSelected: gender == "female"){
                        gender = "female"
                    }
                    
                    RadioButton(title: "Мужчина", isSelected: gender == "male") {
                        gender = "male"
                    }
                    
                }
                Text("Контакты")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top,8)
                
                TextField("Номер телефона",text: $phone)
                    .keyboardType(.phonePad)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                TextField("Email",text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button{
                    wantsSMS.toggle()
                }label: {
                    HStack(alignment: .top, spacing: 8){
                        Image(systemName: wantsSMS ? "checkmark.square.fill" : "square")
                            .foregroundStyle(wantsSMS ? .accentOrange : .gray)
                        Text("Я хочу получать информацию о скидках и спецпредложениях по SMS")
                        
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                        Spacer()
                        
                    }
                }
                .buttonStyle(.plain)
                Button{
                    wantsEmail.toggle()
                }label: {
                    HStack(alignment: .top, spacing: 8){
                        Image(systemName: wantsEmail ? "checkmark.square.fill" : "square")
                            .foregroundStyle(wantsEmail ? .accentOrange : .gray)
                        Text("Я так же хочу получать информацию о скдиках и спецпредложениях по Email")
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                Button{
                    saveChanges()
                }label: {
                    Text("Сохранить изменения")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,16)
                        .background(Color.accentOrange)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                Button{
                    userStore.logout()
                    dismiss()
                }label: {
                    Text("Удалить аккаунт")
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,16)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
                .buttonStyle(.plain)
            }
            .padding(16)
            .onAppear{
                guard let user = userStore.currentUser else {return}
                name = user.name
                phone = user.phone
                email = user.email ?? ""
                gender = user.gender ?? "female"
                wantsSMS = user.wantsSMS
                wantsEmail = user.wantsSMS
                
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
UserDataViews()
        .environmentObject(UserStore())
}
