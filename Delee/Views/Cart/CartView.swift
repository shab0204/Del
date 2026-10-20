//
//  CartView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 01/09/26.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartStore: CartStore
    @State private var showCheckout = false
    var body:some View {
       
            NavigationStack{
                VStack(spacing:0){
                if cartStore.items.isEmpty{
                    Text("Корзина пуста")
                        .foregroundStyle(.secondary)
                }
                else{
                    List{
                        ForEach(cartStore.items){ item in
                            HStack{
                                AsyncImage(url: URL(string: item.dish.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60, height: 60)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))

                                VStack(alignment: .leading,spacing:4){
                                    Text(item.dish.name)
                                        .font(.headline)
                                    Text("\(item.quantity) шт")
                                        .fontWeight(.semibold)
                                }
                                Spacer()
                                
                                Text("\(item.totalPrice) ₽")
                                    .fontWeight(.semibold)
                            }
                            
                        }
                        .onDelete { indexSet in
                            cartStore.remove(atOffsets: indexSet)
                        }
                    }
                    HStack{
                    
                        VStack(alignment: .leading, spacing: 2){
                            Text("Итого")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("\(cartStore.totalPrice) ₽")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        Button{
                           showCheckout = true
                        }label: {
                            Text("Оформить")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.horizontal,24)
                                .padding(.vertical,14)
                                .background(Color.accentOrange)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                    
                    .padding(16)
                    .background(Color(.systemBackground))
                }
            }
            
           
            .sheet(isPresented: $showCheckout ){
                CheckoutView()
            }
                .navigationTitle("Корзина")}
         
    }
}


#Preview {
 CartView()
        .environmentObject(CartStore())
        .environmentObject(UserStore())
        .environmentObject(OrderStore())  
}
