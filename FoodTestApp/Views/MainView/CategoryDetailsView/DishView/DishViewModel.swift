//
//  DishViewModel.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import Foundation
import Combine

final class DishViewModel: ObservableObject {
    
    let imageDownloadManager = ImageDownloadManager.shared
    var cancellable = Set<AnyCancellable>()
    
    @Published var dish: Dish?
    
    init(dish: Dish) {
        self.dish = dish
        setDishImage()
    }
    
    @Published var imageData: Data? = nil
    
    var dishName: String {
        dish?.name ?? ""
    }
    
    func setDishImage() {
        guard let dish = dish else { return }
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
    
}
