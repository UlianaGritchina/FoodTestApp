//
//  DishCell.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 03.07.2023.
//

import SwiftUI

enum StepperType: String {
    case plus = "plusIcon"
    case minus = "minusIcon"
}

struct DishCell: View {
    let savedDish: SavedDish
    let plusAction: () -> ()
    let minusAction: () -> ()
    
    private var dishImageViewModel: DishImageViewModel
    
    init(savedDish: SavedDish, plusAction: @escaping () -> (), minusAction: @escaping () -> ()) {
        self.savedDish = savedDish
        self.plusAction = plusAction
        self.minusAction = minusAction
        dishImageViewModel = DishImageViewModel(savedDish: savedDish, width: 62, height: 62)
    }
    
    var body: some View {
        HStack {
            dishInfo
            
            Spacer()
            
            stepper
        }
        .padding(.horizontal, 16)
    }
}

extension DishCell {
    
    // MARK: Dish info
    
    private var dishInfo: some View {
        HStack {
            DishImageView(viewModel: dishImageViewModel)
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text(savedDish.name ?? "")
                
                dishPriceWeight
            }
            .font(.custom("SFProDisplay-Regular", size: 14))
        }
    }
    
    private var dishPriceWeight: some View {
        HStack(alignment: .center, spacing: 5) {
            Text("\(savedDish.price ?? 0) ₽")
            
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 2, height: 2)
                .opacity(0.4)
            
            Text("\(savedDish.weight ?? 0)г")
                .opacity(0.4)
        }
    }
    
    
    // MARK: Stepper
    
    private var stepper: some View {
        HStack {
            stepperButton(type: .minus)
            
            Spacer()
            
            Text("\(savedDish.count)")
                .font(.custom("SFProDisplay-Regular", size: 14))
            
            Spacer()
            
            stepperButton(type: .plus)
        }
        .frame(width: 99, height: 32)
        .padding(.horizontal, 6)
        .background(Color.appGray)
        .cornerRadius(10)
    }
    
    private func stepperButton(type: StepperType) -> some View {
        Button(action: {
            switch type {
            case .plus:  plusAction()
            case .minus: minusAction()
            }
        }) {
            Image(type.rawValue)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
    
}

