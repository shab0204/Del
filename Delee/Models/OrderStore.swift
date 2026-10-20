//
//  OrderStore.swift
//  Delee
//
//  Created by Шабнам Шарипова on 06/10/26.
//

import Foundation
import Combine

class OrderStore: ObservableObject{
    @Published var orders: [Order] = []
    private var fileURL: URL{
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("order.json")
        
    }
    private func save(){
        do {
            let data = try JSONEncoder().encode(orders)
            try data.write(to: fileURL)
            print("ЗАКАЗЫ СОХРАНЕНЫ:", orders.count)
        }catch{
            print("ОШИБКА СОХРАНЕНИЯ ЗАКАЗОВ:", error)
        }
    }
    private func load(){
        do{
            let data = try Data(contentsOf: fileURL)
            orders = try JSONDecoder().decode([Order].self, from: data)
            print("ЗАКАЗЫ ЗАГРУЖЕНЫ:", orders.count)
        }catch{
            orders = []
        }
    }
    func add(_ order: Order) {
        orders.insert(order, at: 0)
        save()
    }
    
    init(){
        load()
    }
}
