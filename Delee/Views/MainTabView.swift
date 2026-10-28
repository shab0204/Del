//
//  MainTabView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var cartStore:CartStore
    @EnvironmentObject var dishStore:DishStore
    @EnvironmentObject var userStore:UserStore
    @EnvironmentObject var favoritesStore:FavoritesStore

    var body:some View {
        
            
            
        TabView {
            HomeView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Главная")
                    
                }
            
            
            OrdersView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Заказы")
                }
            
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Профиль")
                }
            
            
            PromoView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Промо")
                }
            CartView()
                .tabItem{
                    Image(systemName:"cart")
                    Text("Корзина")
                }
                .badge(cartStore.totalCount)
        }
        .onAppear{
            favoritesStore.switchUser(phone: userStore.currentUser?.phone)
        }
        .onChange(of: userStore.currentUser?.phone){
            _,newPhone in
            favoritesStore.switchUser(phone: newPhone)
        }
    }
}


#Preview {
    MainTabView()
        .environmentObject(UserStore())
              .environmentObject(CartStore())
              .environmentObject(FavoritesStore())
              .environmentObject(DishStore())
              .environmentObject(OrderStore())

}
