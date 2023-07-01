//
//  CategoryApiManager.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import Foundation
import Combine

final class CategoryApiManager {
    
    static let shared = CategoryApiManager()
    private init() { }
    
    private let apiURLString = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
    
    func downloadCategories() -> AnyPublisher<Categories?, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: apiURLString)!)
            .map(handleCategoriesResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func handleCategoriesResponse(data: Data?, response: URLResponse?) -> Categories {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            print("data or code")
            return Categories(сategories: [])
        }
        guard  let categories = try? JSONDecoder().decode(Categories.self, from: data) else {
            print("no decode")
            return Categories(сategories: [])
        }
        return categories
    }
    
}
