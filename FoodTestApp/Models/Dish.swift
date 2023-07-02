//
//  Dish.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import Foundation

struct Dishes: Codable {
    let dishes: [Dish]
}

struct Dish: Codable, Identifiable {
    let id: Int?
    let name: String?
    let price: Int?
    let weight: Int?
    let description: String?
    let image_url: String?
    let tegs: [String]?
    
}
