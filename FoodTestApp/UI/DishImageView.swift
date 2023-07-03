//
//  DishImageView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 03.07.2023.
//

import SwiftUI
import Combine

final class DishImageViewModel: ObservableObject {
    
    let imageDownloadManager = ImageDownloadManager.shared
    var cancellable = Set<AnyCancellable>()
    
    @Published var imageData: Data? = nil
    @Published var dish: Dish?
    @Published var savedDish: SavedDish?
    var width: CGFloat
    var height: CGFloat
    
    init(dish: Dish? = nil, savedDish: SavedDish? = nil, width: CGFloat = 109, height: CGFloat = 109) {
        self.dish = dish
        self.savedDish = savedDish
        self.width = width
        self.height = height
        setDishImage()
    }
    
    func setDishImage() {
        if let savedDish = savedDish {
            imageData = savedDish.imageData
        } else {
            fetchImageData()
        }
    }
    
    private func fetchImageData() {
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

struct DishImageView: View {
    @StateObject var viewModel: DishImageViewModel
    var body: some View {
        dishImageView
    }
}

struct DishImageView_Previews: PreviewProvider {
    static var previews: some View {
        DishImageView(viewModel: DishImageViewModel(dish: Dish(id: 1, name: "name", price: 200, weight: 400, description: "description", image_url: "", tegs: [])))
    }
}

extension DishImageView {
    
    private var dishImageView: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: viewModel.width, height: viewModel.height)
            .foregroundColor(.appGray)
            .overlay { dishImage }
    }
    
    private var dishImage: some View {
        VStack {
            if let imageData = viewModel.imageData {
                Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFit()
                    .padding(.leading, 16)
                    .padding(.top, 13)
            } else {
                ProgressView()
            }
        }
    }
    
}
