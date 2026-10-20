//
//  DishCard.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//
import SwiftUI

struct DishCard: View {
    let dish: Dish
    @EnvironmentObject var favoritesStore:FavoritesStore
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            AsyncImage(url: URL(string: dish.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 160)
            .frame(maxWidth: .infinity)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(alignment: .topTrailing) {
                Button {
                    favoritesStore.toggle(dish)
                } label: {
                    Image(systemName: favoritesStore.isFavorite(dish) ? "heart.fill" : "heart")
                        .font(.system(size: 14))
                        .foregroundStyle(favoritesStore.isFavorite(dish) ? .white : .gray)
                        .scaleEffect(favoritesStore.isFavorite(dish) ? 1.3 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.4),
                                   value: favoritesStore.isFavorite(dish))
                        .padding(7)
                        .background(favoritesStore.isFavorite(dish) ? Color.accentOrange : Color.white)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .padding(10)
            }
            .overlay(alignment: .topLeading) {
                if let discount = dish.discountPercent {
                    Text("-\(discount)%")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(LinearGradient.badgeBlue)
                        .clipShape(Capsule())
                        .padding(10)
                }
            }
           
                .overlay(alignment: .topLeading) {
                    if let discount = dish.discountPercent {
                        Text("-\(discount)%")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(LinearGradient.badgeBlue)
                            .clipShape(Capsule())
                            .padding(10)

                    }

                }

            Text(dish.name)
                .font(.headline)
                .lineLimit(2)
                .frame(height: 44,alignment: .top)
            Text(dish.category)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top, 4)
            HStack(spacing: 4) {
                Text("\(dish.price) ₽")
                    .font(.subheadline)
                    .fontWeight(.bold)
                if let oldPrice = dish.oldPrice {
                    Text("\(oldPrice) ₽")
                        .strikethrough()
                        .opacity(0.7)
                        .font(.subheadline)
                }
                Image(systemName: "plus")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.accentOrange)
                    .padding(5)
                    .background(Color.white)
                    .clipShape(Circle())
            }

            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.accentOrange)
            .clipShape(Capsule())

        }
        .padding(12)
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
