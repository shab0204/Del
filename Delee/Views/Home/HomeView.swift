//
//  HomeView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//
import SwiftUI

struct HomeView: View {

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var promoDish: [Dish] {
        dishStore.dishes.filter { $0.hasDiscount }
    }

    var categories: [String] {
        Array(Set( dishStore.dishes.map { $0.category })).sorted()
    }

    func dishes(in category: String) -> [Dish] {
        dishStore.dishes.filter { $0.category == category }
    }

    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var dishStore: DishStore
    @State private var showLogin: Bool = false
    @State private var scrollTarget: String?
    @State private var selectedDish: Dish?
    @State private var selectedCategory:String?
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 8){
                    Image(systemName: "figure.run")
                        .font(.system(size: 18))
                        .foregroundStyle(.accentOrange)
                        .frame(width: 40,height: 40)
                        .background(Color.accentOrange.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    
                    VStack(alignment: .leading, spacing: 2){
                        HStack(spacing: 4){
                            Text("Некрасова 24к11")
                                .font(.headline)
                           Image(systemName: "chevron.right")
                                .font(.system(size: 12,weight: .semibold))
                          
                        }
                        Text("Адрес доставки")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button{
                        showLogin = true
                    }
                    label:{
                        HStack(spacing:6){
                            Text(userStore.currentUser?.name ?? "Войти")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            if userStore.currentUser == nil{
                              
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 12,weight: .bold))
                            }
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal,16)
                        .padding(.vertical,10)
                        .background(Color.accentOrange)
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                                scrollTarget = category
                            } label: {
                                Text(category)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(selectedCategory == category ? .white : .primary)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(selectedCategory == category ? Color.black : Color(.systemBackground))
                                  
                                    .clipShape(Capsule())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(categories, id: \.self) { category in
                                VStack(alignment: .leading, spacing: 12) {

                                    Text(category)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    LazyVGrid(columns: columns, spacing: 16) {
                                        ForEach(dishes(in: category)) { dish in
                                            Button {
                                                selectedDish = dish
                                            } label: {
                                                DishCard(dish: dish)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                }
                                .id(category)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .onChange(of: scrollTarget) { _, newValue in
                        guard let newValue else { return }
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                        scrollTarget = nil
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
        .task {
            if dishStore.dishes.isEmpty {
                await dishStore.loadAll()
            }
        }
        .sheet(isPresented: $showLogin) {
            LoginView()
        }
        .sheet(item: $selectedDish) { dish in
            DishDetailView(dish: dish)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserStore())
        .environmentObject(CartStore())
        .environmentObject(FavoritesStore())
        .environmentObject(DishStore())
 
}
