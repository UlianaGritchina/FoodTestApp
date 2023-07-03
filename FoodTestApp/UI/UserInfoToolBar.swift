//
//  UserInfoToolBar.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 03.07.2023.
//

import SwiftUI

struct UserInfoToolBar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            UserLocationView()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Image("userImage")
                .resizable()
                .frame(width: 44, height: 44)
        }
    }
}

