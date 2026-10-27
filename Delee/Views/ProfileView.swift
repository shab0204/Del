//
//  ProfileView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userStore: UserStore
    @State private var showLogin = false
    @State private var avatarImage : UIImage?
    @State private var showImagePicker = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    VStack(alignment: .leading,spacing: 16){
                        HStack(spacing:12){
                            Button{
                                showImagePicker = true
                            }label: {
                                if let avatarImage {
                                    Image(uiImage: avatarImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 44, height: 44)
                                        .clipShape(Circle())
                                }
                                else{
                                    Image(systemName: "person.circle")
                                        .font(.system(size: 36))
                                        .foregroundStyle(.white)
                                    
                                }
                            }
                            .buttonStyle(.plain)
                            Text(userStore.currentUser?.name ?? "Гость")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14,weight: .semibold))
                            
                            Spacer()
                        }
                        if userStore.currentUser != nil{
                            Text("Твои баллы в текущем месяце")
                                .font(.subheadline)
                            HStack(spacing:12){
                                VStack(alignment: .leading, spacing: 4){
                                    HStack(spacing:6){
                                        Text("100")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Image(systemName: "seal.fill")
                                    }
                                    Text("1 бонус = 1 ₽")
                                        .font(.caption)
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(16)
                                .background(Color.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                NavigationLink {
                                    OrdersView()
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Image(systemName: "doc.text")
                                            .font(.system(size: 20))
                                        Text("История заказов")
                                            .font(.caption)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(16)
                                    .background(Color.white.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                                .buttonStyle(.plain)
                                
                                
                            }
                            
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentOrange)
                    .foregroundStyle(.white)
                    VStack(alignment: .leading,spacing:12){
                        if userStore.currentUser == nil{
                            VStack(alignment: .leading,spacing: 12){
                                Text("Войти в аккаунт")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("Войдите в аккаунт чтобы воспользоваться всеми функциями приложения")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                                Button{
                                    showLogin = true
                                }label: {
                                    HStack(spacing:8){
                                        Text("Войти в профиль")
                                            .fontWeight(.semibold)
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 14,weight: .bold))
                                    }
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical,16)
                                    .background(Color.accentOrange)
                                    .clipShape(Capsule())
                                    
                                }
                                .buttonStyle(.plain)
                                //                                ProfileRow(icon: "flag", title: "Филиалы", subtitle: "Список доступных филиалов")
                                NavigationLink{
                                    ScheduleView()
                                }label: {
                                    ProfileRow(icon: "clock", title: "График работы", subtitle: "График работы заведения")
                                }
                                .buttonStyle(.plain)
                                
                            }
                            
                        }
                        else{
                            Text("Другое")
                                .font(.title2)
                                .fontWeight(.bold)
                            NavigationLink{
                                AddressesView()
                            }label: {
                                ProfileRow(icon: "mappin", title: "Мои адреса", subtitle: "Управление адресами")
                            }
                            .buttonStyle(.plain)
                            
                            //                            ProfileRow(icon: "bell", title: "Уведомления", subtitle: "Последние уведомления")
                            //                            ProfileRow(icon: "checkmark.seal", title: "Промокоды", subtitle: "Управление промокодами")
                            NavigationLink{
                                FavoritesView()
                            }label: {
                                ProfileRow(icon: "heart.fill", title: "Мои блюда", subtitle: "Ваши сохранённые блюда")
                            }
                            .buttonStyle(.plain)
                            NavigationLink{
                                UserDataViews()
                            }label:{
                                ProfileRow(icon: "doc.text", title: "Мои данные", subtitle: "Изменение и добавление информации")
                            }.buttonStyle(.plain)
                            //                            ProfileRow(icon: "creditcard", title: "Привязанные карты", subtitle: "Привязка и удаление карт")
                            //                            ProfileRow(icon: "flag", title: "Филиалы", subtitle: "Список доступных филиалов")
                            NavigationLink{
                                ScheduleView()
                            }label: {
                                ProfileRow(icon: "clock", title: "График работы", subtitle: "График работы заведения")
                            }
                            .buttonStyle(.plain)
                            
                            Button{
                                userStore.logout()
                            }label: {
                                Text("Выйти")
                                    .font(.headline)
                                    .foregroundStyle(.red)
                                    .frame(maxWidth: .infinity)
                                    .padding(16)
                            }
                            .buttonStyle(.plain)
                            
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                
            }
            .background(Color(.systemGroupedBackground))
            .background(Color.accentOrange.ignoresSafeArea(edges: .top))
            
        }
        
        .sheet(isPresented: $showLogin ){
            LoginView()
        }
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: $avatarImage)
        }
    }
}
#Preview {
    ProfileView()
        .environmentObject(UserStore())
}
