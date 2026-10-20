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
