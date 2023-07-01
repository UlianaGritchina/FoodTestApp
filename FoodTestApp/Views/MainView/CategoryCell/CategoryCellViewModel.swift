//
//  CategoryCellViewModel.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import Foundation
import Combine

final class CategoryCellViewModel: ObservableObject {
    
    private var imageDownloadManager = ImageDownloadManager.shared
    var cancellable = Set<AnyCancellable>()
    
    @Published var category: Сategory
    @Published var imageData: Data? = nil
    
    init(category: Сategory) {
        self.category = category
        setCategoryImage(category)
    }
    
    func setCategoryImage(_ category: Сategory) {
        guard let imageUrl = URL(string: category.imageURL ?? "") else {
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
