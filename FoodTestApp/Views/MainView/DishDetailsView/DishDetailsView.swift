//
//  DishDetailsView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import SwiftUI

struct DishDetailsView: View {
    @EnvironmentObject var viewModel: DishDetailsViewModel
    var body: some View {
        ZStack {
            backgroundView
            dishCard
        }
        .opacity(viewModel.isShow ? 1 : 0)
        .animation(.easeOut(duration: 0.3), value: viewModel.isShow)
    }
}

struct DishDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DishDetailsView()
    }
}

extension DishDetailsView {
    
    private var dishCard: some View {
        VStack {
            dishImageView
            
            dishInfo
            
            addButton
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal, 16)
    }
    
    private var dishInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.selectedDish?.name ?? "")
                .font(.custom("SFProDisplay-Medium", size: 16))
            
            HStack(alignment: .center, spacing: 5) {
                Text("\(viewModel.selectedDish?.price ?? 0) ₽")
                
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 2, height: 2)
                    .opacity(0.4)
                
                Text("\(viewModel.selectedDish?.weight ?? 0)г")
                    .opacity(0.4)
            }
            .font(.custom("SFProDisplay-Regular", size: 16))
            
            Text(viewModel.selectedDish?.description ?? "")
                .opacity(0.65)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var dishImageView: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.appGray)
            .frame(height: 232)
            .overlay { dishImage }
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 8) {
                    squareButton(imageName: "heart", action: {})
                    squareButton(imageName: "cross", action: viewModel.close)
                }
                .padding(8)
            }
    }
    
    private var dishImage: some View {
        VStack {
            if let imageData = viewModel.imageData {
                Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
    }
    
    private var addButton: some View {
        AppButtonView(title: "Добавить в корзину", action: viewModel.addDishToCart)
            .padding(.top, 8)
    }
    
    private var backgroundView: some View {
        Rectangle()
            .ignoresSafeArea()
            .opacity(0.4)
            .onTapGesture { viewModel.close() }
    }
    
    private func squareButton(imageName: String, action: @escaping () -> ()) -> some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
        }
    }
    
}
