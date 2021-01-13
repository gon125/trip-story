//
//  ButtonModifier.swift
//  TripStory
//
//  Created by Gon on 2021/01/12.
//

import SwiftUI
import Combine

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.buttonText)
            .frame(maxWidth: .infinity, maxHeight: .buttonMaxHeight)
            .background(Color.white)
            .cornerRadius(.buttonCornerRadius)
            .foregroundColor(.major)
    }
}

struct TextButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.regularText)
            .background(Color.major)
            .foregroundColor(.white)
    }
}
