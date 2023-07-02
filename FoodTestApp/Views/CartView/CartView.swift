//
//  CartView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import SwiftUI

final class CartViewModel: ObservableObject {
    
    let userDefaultsManager = UserDefaultsManager.shared
    
    @Published var savedDishes = UserDefaultsManager.shared.getSavedDishes()
    
    func getSavedDishes() {
        savedDishes = userDefaultsManager.getSavedDishes()
    }
    
}

struct CartView: View {
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(viewModel.savedDishes) { dish in
                    DishView(viewModel: DishViewModel(dish: dish))
                }
            }
            .toolbar {
                userLocationInfoView
                userImageView
            }
            .onAppear {
                viewModel.getSavedDishes()
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        
        CartView()
    }
}

extension CartView {
    
    private var userImageView: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image("userImage")
                .resizable()
                .frame(width: 44, height: 44)
        }
    }
    
    private var userLocationInfoView: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            UserLocationView()
        }
    }
    
}
