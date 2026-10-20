//
//  DishDetailView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import SwiftUI

struct DishDetailView: View {
    let dish: Dish
    @Environment(\.dismiss) private var dismiss
    @State private var selections: [String:String] = [:]
    @State private var quantity = 1
    @EnvironmentObject var cartStore: CartStore
    var basePrice: Int{
        for option in dish.options{
            if let selectedId = selections[option.id],
               let value = option.values.first(where:{$0.id == selectedId}),
               let price = value.price{
                return price
            }
            
        }
        return dish.price
    }
    var priceTotal: Int{
        basePrice * quantity
    }
    var body: some View {
        VStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    AsyncImage(url: URL(string: dish.image)){
                        image in
                        image
                            .resizable()
                            .scaledToFill()
                    }placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    .clipped()
                        .overlay(alignment: .topLeading) {
                            if let discount = dish.discountPercent {
                                Text("-\(discount)%")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(LinearGradient.badgeBlue)
                                    .clipShape(Capsule())
                                    .padding(16)
                                
                            }
                        }
                        .overlay(alignment: .topTrailing){
                            Button{
                                dismiss()
                            }label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 14,weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .background(.black.opacity(0.4))
                                    .clipShape(Circle())
                            }
                            .padding(16)
                        }
                    VStack(alignment: .leading, spacing: 12) {
                        Text(dish.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(dish.category)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(dish.description)
                            .font(.body)
                        
                        ForEach(dish.options){ option in
                            VStack(alignment: .leading, spacing: 8){
                                Text(option.title)
                                    .font(.headline)
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing:8){
                                        ForEach(option.values) { value in
                                            Button{
                                                selections[option.id] = value.id
                                            }
                                            label: {
                                                VStack(spacing:2){
                                                    Text(value.title)
                                                        .font(.subheadline)
                                                    
                                                    if let price = value.price{
                                                        Text("\(price) ₽")
                                                            .font(.headline)
                                                    }
                                                }
                                                .padding(.horizontal,16)
                                                .padding(.vertical,10)
                                                .background(
                                                    selections[option.id] == value.id ?
                                                    Color(
                                                        .systemBackground
                                                    ) : Color.clear
                                                )
                                                .clipShape(
                                                    RoundedRectangle(
                                                        cornerRadius: 12
                                                    )
                                                )
                                            }
                                            .buttonStyle(.plain)
                                            
                                        }
                                        
                                    }
                                    .padding(4)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                                
                            }
                        }
                        
                    }
                    .padding(.horizontal, 16)
                    
                }
            }.onAppear {
                for option in dish.options {
                    if let first = option.values.first {
                        selections[option.id] = first.id
                    }}}
        }
        HStack(spacing:18){
            HStack(spacing:16){
                Button{
                    if quantity > 1 { quantity -= 1 }
                }label: {
                    Image(systemName: "minus")
                }
                Text("\(quantity)")
                    .font(.headline)
                    .frame(minWidth: 20)
                Button{
                    quantity += 1
                }label: {
                    Image(systemName: "plus")
                }
            }
            .foregroundStyle(.primary)
            .padding(.horizontal,16)
            .padding(.vertical,22)
            .background(Color(.systemGray6))
            .clipShape(Capsule())
            
            Button{
                let item = CartItem(
                    dish: dish, selection: selections, quantity: quantity, unitPrice: basePrice
                )
                cartStore.add(item)
                dismiss()
            }label: {
                HStack(spacing:8){
                    Image(systemName: "bag")
                    Text("В корзину \(priceTotal) ₽")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical,16)
                .background(Color.accentOrange)
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 8, y: -2)
    }
    
}

#Preview {
    DishCard(dish: Dish(
        idMeal: "52772",
        strMeal: "Тест",
        strMealThumb: "https://www.themealdb.com/images/media/meals/1548772327.jpg"
    ))
    .environmentObject(FavoritesStore())
}


