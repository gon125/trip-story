//
//  TextFieldModifier.swift
//  TripStory
//
//  Created by Gon on 2021/01/12.
//

import SwiftUI
import Combine

struct TextFiledModifier: ViewModifier {
    @Environment(\.injected) private var injected: DIContainer
    @State private var loginFailed: Bool = false
    
    func body(content: Content) -> some View {
        VStack {
            content.foregroundColor(loginFailed ? Color.red : Color.white)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.textInputTitle)
            Divider()
                .frame(height: 2)
                .background(loginFailed ? Color.red : Color.white)
        }
        .onReceive(stateUpdate) {
            switch $0 {
            case .failed: self.loginFailed = true
            default: self.loginFailed = false
            }
        }
        
    }
    
    private var stateUpdate: AnyPublisher<AppState.LoginState, Never> {
        injected.appState.updates(for: \.loginState)
    }
}
