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
            dishesView
                .toolbar { UserInfoToolBar() }
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
    
    private var dishesView: some View {
        VStack {
            if !viewModel.savedDishes.isEmpty {
                dishesScrollView
            } else {
                emptyCartView
            }
        }
    }
    
    private var dishesScrollView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.savedDishes) { dish in
                    DishCell(
                        savedDish: dish,
                        plusAction: { viewModel.plusDish(dish) },
                        minusAction: { viewModel.minusDish(dish) }
                    )
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 80)
        }
        .overlay(alignment: .bottom) {
            AppButtonView(title: "Оплатить \(viewModel.totalSumString) ₽", action: {})
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
    }
    
    private var emptyCartView: some View {
        VStack(spacing: 15) {
            Image(systemName: "cart")
                .font(.system(size: 100))
            Text("В корзине пусто")
                .font(.custom("SFProDisplay-Regular", size: 23))
        }
        .foregroundColor(.secondary)
    }
    
}
