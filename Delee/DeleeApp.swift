//
//  DeleeApp.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import SwiftUI

@main
struct DeleeApp: App {
    @StateObject private var userStore = UserStore()
    @StateObject private var cartStore = CartStore()
    @StateObject private var favoritesStore = FavoritesStore()
    @StateObject private var dishStore = DishStore()
    @StateObject private var orderStore = OrderStore()
    @StateObject private var promoStore = PromoStore()
@State private var promotionStore = PromotionStore()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(userStore)
                .environmentObject(cartStore)
                .environmentObject(favoritesStore)
                .environmentObject(dishStore)
                .environmentObject(orderStore)
                .environmentObject(promoStore)
                .environmentObject(promotionStore)
        }
    }
}
