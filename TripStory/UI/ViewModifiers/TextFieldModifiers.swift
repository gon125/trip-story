//
//  TextFieldModifier.swift
//  TripStory
//
//  Created by Gon on 2021/01/12.
//

import SwiftUI
import Combine

struct LoginTextFiledModifier: ViewModifier {
    @Environment(\.injected) private var injected: DIContainer
    @State private var errorDetected: Bool = false
    let checkingError: LoginError
    @State private var errorDescription: LocalizedStringKey = ""

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content.foregroundColor(errorDetected ? Color.red : Color.white)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.textInputTitle)
            Divider()
                .frame(height: 2)
                .background(errorDetected ? Color.red : Color.white)
            Text(errorDetected ? errorDescription : "").font(.textInputDescription).foregroundColor(.red)
        }
        .onReceive(stateUpdate) {
            switch $0 {
            case let .failed(error):
                if checkingError == error {
                    self.errorDetected = true
                    errorDescription = LocalizedStringKey(error.description)
                }
            default:
                self.errorDetected = false
            }
        }

    }

    private var stateUpdate: AnyPublisher<LoginState, Never> {
        injected.appState.updates(for: \.loginState)
    }
}

struct TextFiledModifier: ViewModifier {
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