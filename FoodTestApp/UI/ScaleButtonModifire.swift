//
//  ScaleButtonModifire.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .brightness(configuration.isPressed ? -0.05 : 0)
    }
}
