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
    var cancellable = Set<AnyCancellable>()
    
    @Published var selectedDish: Dish?
    @Published var isShow = false
    @Published var imageData: Data? = nil
    
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
        selectedDish = nil
    }
    
}
