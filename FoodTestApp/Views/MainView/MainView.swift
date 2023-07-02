//
//  ContentView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.categories.isEmpty {
                    categoriesScrollView
                } else {
                    ProgressView()
                }
            }
            .toolbar {
                userLocationInfoView
                userImageView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    
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
    
    private var categoriesScrollView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.categories) { category in
                    categoryNavLink(category)
                }
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 16)
    }
    
    private func categoryNavLink(_ category: Сategory) -> some View {
        NavigationLink(destination: CategoryDetailsView(category: category)) {
            CategoryCell(viewModel: CategoryCellViewModel(category: category))
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
}

