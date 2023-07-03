//
//  TabBarView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var dishDetailsViewModel = DishDetailsViewModel()
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image("homeIcon")
                    Text("Главная")
                }
                .environmentObject(dishDetailsViewModel)
            
            NoContentView()
                .tabItem {
                    Image("searchIcon")
                    Text("Поиск")
                }
            
            CartView()
                .tabItem {
                    Image("cartIcon")
                    Text("Корзина")
                }
            
            NoContentView()
                .tabItem {
                    Image("accountIcon")
                    Text("Аккаунт")
                }
        }
        .overlay {
            DishDetailsView()
                .environmentObject(dishDetailsViewModel)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
