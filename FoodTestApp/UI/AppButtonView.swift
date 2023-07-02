//
//  AppButtonView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import SwiftUI

struct AppButtonView: View {
    let title: String
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("SFProDisplay-Medium", size: 16))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(Color.accentColor)
                .cornerRadius(10)
        }
    }
}

struct AppButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AppButtonView(title: "title", action: {})
    }
}
