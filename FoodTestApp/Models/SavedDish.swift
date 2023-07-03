//
//  SavedDish.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 03.07.2023.
//

import Foundation

struct SavedDish: Codable, Identifiable, Equatable, Hashable {
    
    let id: Int?
    let name: String?
    let price: Int?
    let weight: Int?
    let description: String?
    let imageData: Data?
    let tegs: [String]?
    var count: Int
    
    init (dish: Dish, imageData: Data) {
        let savedDishes = UserDefaultsManager.shared.getSavedDishes()
        
        var count = 1
        
        for savedDish in savedDishes {
            if savedDish.id == dish.id {
                count = savedDish.count + 1
            }
        }
        
        self.id = dish.id
        self.name = dish.name
        self.price = dish.price
        self.weight = dish.weight
        self.description = dish.description
        self.tegs = dish.tegs
        self.count = count
        self.imageData = imageData
    }
    
}
