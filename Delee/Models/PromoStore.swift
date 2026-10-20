//
//  PromoStore.swift
//  Delee
//
//  Created by Шабнам Шарипова on 08/10/26.
//

import Foundation
import Combine

class PromoStore:ObservableObject{
    @Published var promos: [Promo] = [
        Promo(code: "PRO-1234", discount: 20, expiresAt: "20.02.2027", isActivated: false),
         Promo(code: "SALE-50", discount: 50, expiresAt: "01.03.2027", isActivated: false),
         Promo(code: "FIRST-15", discount: 15, expiresAt: "15.03.2027", isActivated: false),
         Promo(code: "WEEKEND", discount: 10, expiresAt: "30.03.2027", isActivated: false),
         Promo(code: "DELEE-25", discount: 25, expiresAt: "10.04.2027", isActivated: false)
    ]
    func activate( _ promo: Promo){
        if let index = promos.firstIndex(where: { $0.id == promo.id }){
            promos[index].isActivated = true
            save()
        }
    }
    private var fileURL: URL{
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("promos.json")
    }
    private func save(){
        do{
            let data = try JSONEncoder().encode(promos)
            try data.write(to: fileURL)
        }catch{
            print("ОШИБКА СОХРАНЕНИЯ ПРОМОКОДОВ:", error)
        }
    }
    private func load(){
        do{
            let data = try Data(contentsOf: fileURL)
            promos = try JSONDecoder().decode([Promo].self, from: data)
        }
        catch{}
        
    }
    init(){
        load()
    }
}
