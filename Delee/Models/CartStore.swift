//
//  CartStore.swift
//  Delee
//
//  Created by Шабнам Шарипова on 12/09/26.
//

import SwiftUI
import Combine

class CartStore: ObservableObject {
    private var fileURL:URL{
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("cart.json")
    }
    private func save(){
        do{
            let data = try JSONEncoder().encode(items)
            try data.write(to: fileURL)
            print("КОРЗИНА СОХРАНЕНА:", items.count, "позиций")
        }
        catch{
            print("ОШИБКА СОХРАНЕНИЯ КОРЗИНЫ:", error)
        }
    }
    private func load(){
        do{
            let data = try Data(contentsOf: fileURL)
            items = try JSONDecoder().decode([CartItem].self, from: data)
            print("КОРЗИНА ЗАГРУЖЕНА:", items.count, "позиций")
        }
        catch{
            items = []
            print("КОРЗИНА НЕ ЗАГРУЖЕНА:", error)
        }
    }
    init(){
        load()
    }
    @Published var items: [CartItem] = []
    var totalPrice:Int{
        items.reduce(0){$0 + $1.totalPrice}
    }
    var totalCount:Int{
        items.reduce(0){$0 + $1.quantity}
    }
    func add(_ item:CartItem){
        items.append(item)
        save()
    }
    func remove(_ item:CartItem){
        items.removeAll{$0.id == item.id}
        save()
    }
    func clear(){
        items.removeAll()
        save()
    }
    func remove(atOffsets offsets:IndexSet){
        items.remove(atOffsets: offsets)
        save()
    }
}
