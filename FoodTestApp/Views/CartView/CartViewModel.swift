//
//  CartViewModel.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 03.07.2023.
//

import Foundation

final class CartViewModel: ObservableObject {
    
    let userDefaultsManager = UserDefaultsManager.shared
    
    @Published var savedDishes = UserDefaultsManager.shared.getSavedDishes()
    @Published var dishesSum = 0
    
    func getSavedDishes() {
        savedDishes = userDefaultsManager.getSavedDishes()
        savedDishes = savedDishes
        setDishesSum()
    }
    
    func setDishesSum() {
        for dish in savedDishes {
            dishesSum += dish.price ?? 0
        }
    }
    
    func plusDish(_ dish: SavedDish) {
        var newDish = dish
        newDish.count += 1
        
        
        for index in 0..<savedDishes.count {
            if savedDishes[index] == dish {
                savedDishes[index] = newDish
            }
        }
        
        userDefaultsManager.saveDishes(savedDishes)
        getSavedDishes()
    }
    
    func minusDish(_ dish: SavedDish) {
        var newDish = dish
        newDish.count -= 1
        
        if newDish.count == 0 {
            savedDishes.removeAll(where: { $0.name == dish.name })
            userDefaultsManager.saveDishes(savedDishes)
            getSavedDishes()
            return
        }
        
        for index in 0..<savedDishes.count {
            if savedDishes[index] == dish {
                savedDishes[index] = newDish
            }
        }
        
        userDefaultsManager.saveDishes(savedDishes)
        getSavedDishes()
    }
    
}

