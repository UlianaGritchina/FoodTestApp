//
//  CartView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.savedDishes.isEmpty {
                    dishesScrollView
                } else {
                    NoContentView()
                }
            }
            .toolbar {
                userLocationInfoView
                userImageView
            }
            .onAppear { viewModel.getSavedDishes() }
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
    
    private var dishesScrollView: some View {
        ScrollView {
            ForEach(viewModel.savedDishes) { dish in
                DishCell(
                    savedDish: dish,
                    plusAction: { viewModel.plusDish(dish) },
                    minusAction: { viewModel.minusDish(dish) }
                )
            }
            .padding(.top, 16)
            .padding(.bottom, 80)
        }
        .overlay(alignment: .bottom) {
            AppButtonView(title: "Оплатить \(viewModel.dishesSum) ₽", action: {})
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
    }
    
}
