//
//  UserDefoultsManager.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() { }
    
    private let dishes = "dishes"
    
    func saveDishes(_ dish: [Dish]) {
        if let encodedData = try? JSONEncoder().encode(dish) {
            UserDefaults.standard.set(encodedData, forKey: dishes)
        }
    }
    
    func getSavedDishes() -> [Dish] {
        guard
            let data = UserDefaults.standard.data(forKey: dishes),
            let dishes = try? JSONDecoder().decode([Dish].self, from: data)
        else { return [] }
        return dishes
    }
    
}
