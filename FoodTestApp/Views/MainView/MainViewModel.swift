//
//  MainViewModel.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    private let categoryApiManager = CategoryApiManager.shared
    private let userLocationManager = UserLocationManager.shared
    
    @Published var categories: [Сategory] = []
    @Published var userLocation = ""
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM, YYY"
        return dateFormatter.string(from: Date())
    }
    
    init() {
        downloadCategories()
        getUserLocation()
    }
    
    private func downloadCategories() {
        categoryApiManager.downloadCategories()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] categories in
                guard let categories = categories else { return }
                self?.categories = categories.сategories
            }
            .store(in: &cancellable)
    }
    
    private func getUserLocation() {
        userLocationManager.getUserLocationName { city in
            guard let city = city else { return }
            self.userLocation = city
        }
    }
    
}

