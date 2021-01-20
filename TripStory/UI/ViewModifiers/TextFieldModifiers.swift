//
//  TextFieldModifier.swift
//  TripStory
//
//  Created by Gon on 2021/01/12.
//

import SwiftUI
import Combine

struct TextFieldModifier: ViewModifier {
    @Binding private var isValid: Bool
    @Binding private var description: String

    init(isValid: Binding<Bool> = .init(.constant(true))!, description: Binding<String> = .init(.constant(""))!) {
        self._isValid = isValid
        self._description = description
    }

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content.foregroundColor(isValid ? Color.white : Color.red)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.textInputTitle)
            Divider()
                .frame(height: 2)
                .background(isValid ? Color.white : Color.red)
            Text(LocalizedStringKey(description)).font(.textInputDescription).foregroundColor(.red)

        }
    }
}
