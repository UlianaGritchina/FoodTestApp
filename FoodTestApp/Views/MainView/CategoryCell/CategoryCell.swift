//
//  KitchenCell.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import SwiftUI

struct CategoryCell: View {
    @ObservedObject var viewModel: CategoryCellViewModel
    var body: some View {
        VStack {
            if let imageData = viewModel.imageData {
                Image(uiImage: (UIImage(data: imageData) ?? UIImage(systemName:  "photo"))!)
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .topLeading) {  categoryName }
                
            }
        }
    }
    
    private var categoryName: some View {
        Text(viewModel.category.name ?? "")
            .multilineTextAlignment(.leading)
            .foregroundColor(.black)
            .padding(.top, 12)
            .padding(.leading, 16)
            .font(.custom("SFProDisplay-Medium", size: 20))
    }
    
}

struct KitchenCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(
            viewModel: CategoryCellViewModel(
                category: Сategory(id: 1, name: "name", imageURL: nil))
        )
    }
}

