//
//  FavoritesStore.swift
//  Delee
//
//  Created by Шабнам Шарипова on 13/09/26.
//

import Foundation
import Combine

class FavoritesStore:ObservableObject{
    private var currentPhone:String?
    private var fileURL: URL{
        let name = currentPhone ?? "Гость"
       return FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("favorites_\(name).json")
    }
    private func save(){
        do{
            let data = try JSONEncoder().encode(favoritIds)
            try data.write(to: fileURL)
            print("СОХРАНИЛ:", favoritIds.count, "шт →", fileURL.path)
        }
        catch{
            print("Не получилось сохранить \(error)")
            print("ОШИБКА СОХРАНЕНИЯ:", error)
        }
    }
    private func load(){
        do{
            let data  = try Data(contentsOf: fileURL)
            favoritIds = try JSONDecoder().decode(Set<String>.self, from: data)
            print("ЗАГРУЗИЛ:", favoritIds.count, "шт")
        }
        catch{
            favoritIds = []
            print("НЕ ЗАГРУЗИЛ:", error)
        }
    }
    init(){
        load()
    }
    @Published var favoritIds:Set<String> = []
    func isFavorite(_ dish:Dish) -> Bool{
        favoritIds.contains(dish.id)
    }
    func toggle(_ dish:Dish){
        if favoritIds.contains(dish.id){
            favoritIds.remove(dish.id)
        }
        else {
            favoritIds.insert(dish.id)
        }
        save()
    }
    func clear(){
        favoritIds.removeAll()
        save()
    }
    func switchUser(phone:String?){
        currentPhone = phone
        load()
    }
}
