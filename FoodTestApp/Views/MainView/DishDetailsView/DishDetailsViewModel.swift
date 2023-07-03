//
//  DishDetailsViewModel.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import Foundation
import Combine

final class DishDetailsViewModel: ObservableObject {
    
    let imageDownloadManager = ImageDownloadManager.shared
    let userDefaultsManager = UserDefaultsManager.shared
    
    var cancellable = Set<AnyCancellable>()
    var savedDishes: [SavedDish] = []
    
    @Published var selectedDish: Dish?
    @Published var isShow = false
    @Published var imageData: Data? = nil
    
    init() {
        savedDishes = userDefaultsManager.getSavedDishes()
    }
    
    func setDishImage() {
        guard let dish = selectedDish else { return }
        guard let imageUrl = URL(string: dish.image_url ?? "") else {
            return
        }
        imageDownloadManager.fetchImageData(url: imageUrl)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] imageData in
                guard let data = imageData else { return  }
                self?.imageData = data
            }
            .store(in: &self.cancellable)
    }
    
    func selectDish(_ dish: Dish) {
        selectedDish = dish
        isShow = true
        setDishImage()
    }
    
    func close() {
        isShow = false
        imageData = nil
        selectedDish = nil
    }
    
    func addDishToCart() {
        savedDishes = userDefaultsManager.getSavedDishes()
        guard let dish = selectedDish, let imageData = imageData else { return }
        let dishForSave = SavedDish(dish: dish, imageData: imageData)
        
        if savedDishes.isEmpty {
            savedDishes.append(dishForSave)
            userDefaultsManager.saveDishes(savedDishes)
            return
        }
        
        for index in 0..<savedDishes.count {
            if savedDishes[index].name == dishForSave.name {
                savedDishes[index] = dishForSave
                userDefaultsManager.saveDishes(savedDishes)
                return
            }
        }
        
        savedDishes.append(dishForSave)
        userDefaultsManager.saveDishes(savedDishes)
    }
    
}
