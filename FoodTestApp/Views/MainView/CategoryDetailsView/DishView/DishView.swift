//
//  DishView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import SwiftUI

struct DishView: View {
    @StateObject var viewModel: DishViewModel
    @EnvironmentObject var dishDetailsViewModel: DishDetailsViewModel
    var body: some View {
        Button(action: {
            dishDetailsViewModel.selectDish(viewModel.dish!)
        }) {
            dishContent
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
}

struct DishView_Previews: PreviewProvider {
    static var previews: some View {
        DishView(viewModel: DishViewModel(dish: Dish(id: 1, name: "name", price: 200, weight: 400, description: "description", image_url: "", tegs: [])))
    }
}


extension DishView {
    
    private var dishContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            DishImageView(viewModel: DishImageViewModel(dish: viewModel.dish!))
            
            dishNameView
        }
        .frame(maxWidth: 109)
    }
    
    
    private var dishNameView: some View {
        Text(viewModel.dishName)
            .font(.custom("SFProDisplay-Regular", size: 14))
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
    }
    
}
