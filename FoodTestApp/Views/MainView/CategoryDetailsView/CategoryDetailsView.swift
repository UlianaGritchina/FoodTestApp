//
//  CategoryDetailsView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import SwiftUI

struct CategoryDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = CategoryDetailsViewModel()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let category: Сategory
    
    var body: some View {
        VStack {
            tagPicker
            
            if !viewModel.dishes.isEmpty {
                dishesScrollView
            } else {
                progressView
            }
        }
        .navigationTitle(category.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            backButton
            userImageView
        }
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(
                category: Сategory(id: 2, name: "name", imageURL: nil)
            )
        }
    }
}

extension CategoryDetailsView {
    
    // MARK: NavigationBar
    
    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss() }) {
                Image("backButtonImage")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .offset(x: -7)
            }
        }
    }
    
    private var userImageView: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image("userImage")
                .resizable()
                .frame(width: 44, height: 44)
        }
    }
    
    
    // MARK: TagPicker
    
    private var tagPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.foodTags, id: \.self) { tag in
                    tagButton(tag)
                }
            }
        }
        .padding(.top, 8)
        .padding(.horizontal, 16)
    }
    
    private func tagButton(_ tag: String) -> some View {
        Button(action: { viewModel.selectTag(tag) }) {
            Text(tag)
                .foregroundColor(tag == viewModel.selectedTag ? .white : .black)
                .font(.custom("SFProDisplay-Regular", size: 14))
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    tag == viewModel.selectedTag
                    ? Color.accentColor
                    : .appGray
                )
                .cornerRadius(10)
        }
    }
    
    //MARK: DishesScroll
    
    private var dishesScrollView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(viewModel.sortedDishes) { dish in
                    DishView(viewModel: DishViewModel(dish: dish))
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var progressView: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
}
