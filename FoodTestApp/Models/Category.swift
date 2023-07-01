//
//  Category.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import Foundation

struct Categories: Codable {
    let сategories: [Сategory]
}

struct Сategory: Codable, Identifiable {
    
    let id: Int?
    let name: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
