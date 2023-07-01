//
//  CategoryDetailsView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import SwiftUI

struct CategoryDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    let category: Сategory
    var body: some View {
        VStack {
            
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
        CategoryDetailsView(category: Сategory(id: 2, name: "name", imageURL: nil))
    }
}

extension CategoryDetailsView {
    
    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss() }) {
                Image("backButtonImage")
                    .resizable()
                    .frame(width: 44, height: 44)
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
    
}
