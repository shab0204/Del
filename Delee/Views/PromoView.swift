//
//  PromoView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import SwiftUI

struct PromoView:View {
    @EnvironmentObject private var dishStore:DishStore
    @State private var selectedDish:Dish?
    @State private var selectedTab = 0
    @State private var couponCode = ""
    @State private var couponError = false
    @State private var copiedCode : String?
    @EnvironmentObject  var promotionStore:PromotionStore
    @EnvironmentObject  var promoStore:PromoStore
   
    private func activateCoupon(){
        let trimmed = couponCode.trimmingCharacters(in: .whitespaces)
        if let promo = promoStore.promos.first(where: {$0.code == trimmed && !$0.isActivated}){
            promoStore.activate(promo)
            couponCode = ""
            couponError = false
        }
        else{
            couponError = true
        }
    }
    var body:some View{
        NavigationStack{
            VStack(spacing:0){
                Picker("",selection: $selectedTab){
                    Text("Акции").tag(0)
                    Text("Промокоды").tag(1)
                }.pickerStyle(.segmented)
                    .padding(16)
                
                if selectedTab == 0{
                    Group{
                        if promotionStore.promotions.isEmpty{
                            VStack(spacing:12){
                                Image(systemName: "percent")
                                    .font(.system(size: 28))
                                    .foregroundStyle(.accentOrange)
                                    .frame(width: 64,height: 64)
                                    .background(Color.accentOrange.opacity(0.15))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                Text("Акций пока нет")
                                    .font(.headline)
                            }
                        }
                        else{
                            ScrollView{
                                
                                LazyVStack( spacing:16){
                                    
                                    ForEach(promotionStore.promotions) { promotion in
                                        HStack(spacing:12){
                                            AsyncImage(url: URL(string:promotion.imageURL)){
                                                image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            }
                                            
                                            placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 100,height: 100)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            
                                          
                                            VStack(alignment: .leading,spacing:6){
                                                Text(promotion.title)
                                                    .font(.headline)
                                                Text(promotion.description)
                                                    .font(.subheadline)
                                                    .foregroundStyle(.secondary)
                                                    .lineLimit(3)
                                                if let validUntill = promotion.validUntil{
                                                    Text(validUntill)
                                                        .font(.caption)
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(.white)
                                                        .padding(.horizontal,12)
                                                        .padding(.vertical,6)
                                                        .background(LinearGradient.badgeBlue)
                                                        .clipShape(Capsule())
                                                                .padding(.top, 4)
                                                }
                                            }
                                            Spacer()
                                        }
                                        .padding(12)
                                        .background(Color(.systemBackground))
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .overlay{
                                            RoundedRectangle(cornerRadius:16)
                                                .stroke(Color(.systemGray5),lineWidth: 1)
                                        }
                                    }
                                }
                                .padding(16)
                              
                            }
                            .onTapGesture {
                                UIApplication.shared.sendAction(
                                    #selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil
                                )
                            }
                        }
                    }
                }else{
                    VStack(alignment: .leading,spacing: 6){
                    HStack(spacing:12){
                        TextField("Есть купон?",text: $couponCode)
                            .onChange(of:couponCode){_, _ in
                            couponError = false
                            }
                        Button{
                            activateCoupon()
                        }label: {
                            Text("Активировать")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.horizontal,20)
                                .padding(.vertical,14)
                                .background(Color.accentOrange)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.leading,16)
                    .padding(.trailing,6)
                    .padding(.vertical,6)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay{
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(couponError ? Color.red : Color.clear,lineWidth:1)
                    }
                        if couponError{
                            Text("Срок истёк или купон недействителен")
                                .font(.caption)
                                .foregroundStyle(.red)
                                .padding(.leading,6)
                        }
                }
                    .padding(16)
                    ScrollView{
                        LazyVStack(spacing:12){
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Актуальные промокоды")
                                    .font(.title3)
                                    .fontWeight(.bold)

                                Text("Нажмите на промокод чтобы скопировать его")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)
                            if let copiedCode{
                                Text("Скопировано: \(copiedCode)")
                                       .font(.caption)
                                       .foregroundStyle(.green)
                            }
                            ForEach(promoStore.promos) { promo in
                                Button{
                                    UIPasteboard.general.string = promo.code
                                    copiedCode = promo.code
                                    Task{
                                        try? await Task.sleep(for: .seconds(2))
                                        copiedCode = nil
                                    }
                                }
                                label: {
                                    HStack(spacing:0){
                                       VStack(spacing:2){
                                           Text(promo.code)
                                               .font(.title2)
                                               .fontWeight(.bold)
                                           
                                           Text(promo.isActivated ? "Активирован" : "Нажмите чтобы активировать")
                                               .font(.caption)
                                               .foregroundStyle(promo.isActivated ? Color.accentOrange : .secondary)
                                        }
                                       .frame(maxWidth: .infinity,maxHeight: .infinity)
                                       .overlay(alignment:.topLeading){
                                           Image(systemName: "checkmark.seal.fill")
                                               .font(.system(size: 22))
                                               .foregroundStyle(promo.isActivated ? Color.accentOrange : .gray)
                                                          .padding(12)
                                       }
                                        VStack(spacing: 2){
                                            Text("\(promo.discount)%")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                            Text("Действует до:\n\(promo.expiresAt)")
                                                .font(.caption2)
                                                .multilineTextAlignment(.center)
                                        }
                                        .foregroundStyle(.white)
                                        .frame(width: 120)
                                        .frame(maxHeight: .infinity)
                                        .background(Color.accentOrange)
                                        
                                        .overlay(alignment:.leading){
                                            VStack(spacing:6){
                                                Circle()
                                                           .fill(Color(.systemBackground))
                                                           .frame(width: 16, height: 16)
                                                        
                                                ForEach(0..<5,id: \.self) { _ in
                                                    Circle()
                                                        .fill(Color(.systemBackground))
                                                        .frame(width: 8,height: 8)
                                                    
                                                }
                                                Circle()
                                                           .fill(Color(.systemBackground))
                                                           .frame(width: 16, height: 16)
                                            }
                                            .offset(x: -8)
                                        }
                                        .overlay(alignment:.trailing){
                                            Circle()
                                                .fill(Color(.systemBackground))
                                                .frame(width: 20, height: 20)
                                                .offset(x:10)
                                        }
                                        
                                    }
                                    .frame(height: 100)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))

                                }
                                .buttonStyle(.plain)
                                                          
                            }
                        }
                        .padding(16)
                    }
                }
                
            }
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
            .navigationTitle("Акции  и промокоды")
            .task {
                if dishStore.dishes.isEmpty{
                    await dishStore.loadAll()
                }
                    promotionStore.build(from:dishStore.dishes)
            }
            .sheet(item: $selectedDish){dish in
                DishDetailView(dish: dish)
            }
        }
    }
}

#Preview {
    PromoView()
        .environmentObject(DishStore())
        .environmentObject(FavoritesStore())
        .environmentObject(PromoStore())
        .environmentObject(PromotionStore())
}
