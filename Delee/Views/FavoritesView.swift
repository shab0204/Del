//
//  FavoritesView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 13/09/26.
//

import SwiftUI

struct FavoritesView:View {
    @EnvironmentObject var favoritesStore:FavoritesStore
    @EnvironmentObject var dishStore: DishStore
    @State private var selectedDish: Dish?
    var favoriteDishes:[Dish]{
        dishStore.dishes.filter{favoritesStore.isFavorite($0)}
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            if favoriteDishes.isEmpty{
                VStack(spacing:12){
                    Image(systemName: "heart")
                        .font(.system(size: 28))
                        .foregroundStyle(.accentOrange)
                        .frame(width:64,height: 64)
                        .background(Color.accentOrange.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    Text("Товаров нет")
                        .font(.headline)
                    
                }
                .padding(.top,120)
            }
            else{
                LazyVGrid(columns: columns, spacing: 16){
                    ForEach(favoriteDishes) { dish in
                        Button{
                            selectedDish = dish
                        }label: {
                            DishCard(dish:  dish)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
        }
        .navigationTitle("Избранное")
        .toolbar{
            
            
            ToolbarItem(placement: .topBarTrailing){
                if !favoriteDishes.isEmpty{
                    
                    Button{
                        favoritesStore.clear()
                    }label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .sheet(item:$selectedDish){dish in
        DishDetailView(dish: dish)}
    }
}

#Preview {
    FavoritesView()
    .environmentObject(FavoritesStore())
    .environmentObject(DishStore())
    
}
