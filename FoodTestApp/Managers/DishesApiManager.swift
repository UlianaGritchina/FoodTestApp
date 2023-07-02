//
//  DishesApiManager.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import Foundation
import Combine

final class DishesApiManager {
    
    static let shared = DishesApiManager()
    private init() { }
    
    private let apiURLString = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    
    func downloadDishes() -> AnyPublisher<Dishes?, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: apiURLString)!)
            .map(handleDishesResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func handleDishesResponse(data: Data?, response: URLResponse?) -> Dishes {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            print("data or code")
            return Dishes(dishes: [])
        }
        guard  let dishes = try? JSONDecoder().decode(Dishes.self, from: data) else {
            print("no decode")
            return Dishes(dishes: [])
        }
        return dishes
    }
    
}
