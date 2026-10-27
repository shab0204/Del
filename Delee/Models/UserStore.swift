//
//  UserStore.swift
//  Delee
//
//  Created by Шабнам Шарипова on 04/09/26.
//

import Foundation
import Combine

class UserStore : ObservableObject {
    @Published var currentUser: UserInfo?
    
    func login(name:String, phone:String) {
        currentUser = UserInfo(name: name, phone: phone, email: nil, birthDate: nil,
                               gender: nil,
                               wantsSMS: false,
                               wantsEmail: false)
        save()
    }
    func logout() {
         currentUser = nil
        try? FileManager.default.removeItem(at:fileURL)
     }
    private var fileURL: URL{
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("user.json")
    }
    private func save(){
        do{
            let data = try JSONEncoder().encode(currentUser)
            try data.write(to: fileURL)
            print("save")
        }
        catch{
            print("error")
        }
    }
    private func load(){
        do{
            let data = try Data(contentsOf: fileURL)
            currentUser = try JSONDecoder().decode(UserInfo?.self, from: data)
            print("распакован")
        }
        catch{
            currentUser = nil
            print("ощибка")
        }
    }
    init(){
        load()
    }
    
    func updateProfile(
        name: String,
        birthDate: Date,
        gender: String,
        phone: String,
        email: String,
        wantsSMS: Bool,
        wantsEmail: Bool
    ) {
        currentUser = UserInfo(
            name: name,
            phone: phone,
            email: email,
            birthDate: birthDate,
            gender: gender,
            wantsSMS: wantsSMS,
            wantsEmail: wantsEmail,
            addresses: currentUser?.addresses ?? [],
            selectedAddressID: currentUser?.selectedAddressID
        )
        save()
    }
    func addAddress(title:String,value:String){
        guard var user = currentUser else{return}
        let address = Address(title: title, value: value)
        user.addresses.append(address)
        currentUser = user
        save()
    }
    func selectAddress(_ address:Address){
        guard var user = currentUser else {return}
        user.selectedAddressID = address.id
        currentUser = user
        save()
    }
    func removeAddress(_ address:Address){
        guard var user = currentUser else{return}
        user.addresses.removeAll{$0.id == address.id}
        currentUser = user
        save()
        
    }
    func updateAddress(_ address:Address){
        guard var user = currentUser else {return}
        if let index = user.addresses.firstIndex(where: {$0.id == address.id}){
            user.addresses[index] = address
        }
        currentUser = user
        save()
    }
}

