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
                    Image("homeIcone")
                    Text("Главная")
                }
                .environmentObject(dishDetailsViewModel)
            
            Color.red
                .tabItem {
                    Label("Поиск", systemImage: "bolt.fill")
                }
             
            CartView()
                .tabItem {
                    Label("Корзина", systemImage: "gear")
                }
            
            Color.purple
                .tabItem {
                    Label("Аккаунт", systemImage: "gear")
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
