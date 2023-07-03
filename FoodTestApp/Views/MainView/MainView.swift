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
            .toolbar { UserInfoToolBar() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    
    private var categoriesScrollView: some View {
        ScrollView(showsIndicators: false) {
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


