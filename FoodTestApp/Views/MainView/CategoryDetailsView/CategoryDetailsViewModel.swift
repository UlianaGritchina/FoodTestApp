//
//  CategoryDetailsViewModel.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import Foundation
import Combine

final class CategoryDetailsViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    private let dishesApiManager = DishesApiManager.shared
    
    let foodTags = ["Все меню", "Салаты","С рисом","С рыбой"]
    
    @Published var dishes: [Dish] = []
    @Published var sortedDishes: [Dish] = []
    @Published var selectedTag = "Все меню"
    
    init() {
        downloadDishes()
    }
    
    private func downloadDishes() {
        dishesApiManager.downloadDishes()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] dishes in
                guard let dishes = dishes else { return }
                self?.dishes = dishes.dishes
                self?.sortedDishes = dishes.dishes
            }
            .store(in: &cancellable)
    }
    
    private func sortDishesBy(_ tag: String) {
        sortedDishes = dishes.filter { $0.tegs?.contains(tag) ?? false }
    }
    
    func selectTag(_ tag: String) {
        selectedTag = tag
        sortDishesBy(tag)
    }
    
}
