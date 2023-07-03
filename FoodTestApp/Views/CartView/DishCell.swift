//
//  DishCell.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 03.07.2023.
//

import SwiftUI

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

//struct DishCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DishCell(dish: Dish(
//            id: 1, name: "name",
//            price: 299,
//            weight: 300,
//            description: "description",
//            image_url: "",
//            tegs: []),
//                 plusAction: {},
//                 minusAction: {}
//        )
//    }
//}

extension DishCell {
    
    private var dishInfo: some View {
        HStack {
            DishImageView(viewModel: dishImageViewModel)
            VStack(alignment: .leading, spacing: 3) {
                Text(savedDish.name ?? "")
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
            .font(.custom("SFProDisplay-Regular", size: 14))
        }
    }
    
    private var stepper: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.appGray)
            .frame(width: 99, height: 32)
            .overlay {
                HStack {
                    Button(action: minusAction) {
                        Image("minusIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    
                    Spacer()
                    
                    Text("\(savedDish.count)")
                        .font(.custom("SFProDisplay-Regular", size: 14))
                    
                    Spacer()
                    
                    Button(action: plusAction) {
                        Image("plusIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal, 6)
            }
    }
    
}

