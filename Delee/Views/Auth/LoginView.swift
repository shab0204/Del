//
//  LoginView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userStore: UserStore
    @State private var name = ""
    @State private var phone = ""
    var isFormValid: Bool { !name.isEmpty && phone.count >= 9 }
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 16){
                    TextField("Name", text: $name)
                        .onChange(of: name) { _, newValue in
                            print("ИМЯ:", newValue)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    TextField("Phone", text: $phone)
                    
                        .keyboardType(.phonePad)
                        .onChange(of: phone) { _, newValue in
                            phone = newValue.filter { $0.isNumber }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    Button("Войти"){
                        userStore.login(name:name,phone:phone)
                        dismiss()
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .foregroundStyle(.white)
                    .background(isFormValid ? Color.accentOrange : Color.accentOrange.opacity(0.4))
                    
                    .clipShape(RoundedRectangle(cornerRadius:14))
                    .disabled(!isFormValid)
                }
                .padding()
            }
//          padding(16)
            .onAppear {
                if let user = userStore.currentUser {
                    name = user.name
                    phone = user.phone
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Отмена"){
                        dismiss()
                    }
                }
            }
            
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserStore())
}
