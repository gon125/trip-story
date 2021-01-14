//
//  LoginView.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI
import Combine

struct LoginView: View {

    @Environment(\.injected) private var injected: DIContainer
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Color.major.ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()

                TextField("UserID", text: $username)
                    .modifier(LoginTextFiledModifier(checkingError: LoginError.invalidUsername))
                Spacer().frame(height: 40)
                SecureField("Password", text: $password)
                    .modifier(LoginTextFiledModifier(checkingError: LoginError.invalidPassword))

                Spacer().frame(height: 20)
                HStack { Spacer()
                    NavigationLink(
                        destination: FindPasswordView(username: $username)) {
                        Text("Forgot password?")
                            .modifier(TextButtonModifier())
                    }

                }
                Spacer().frame(height: 60)
                Button(
                    action: { injected.interactors.authenticationInteractor
                        .login(username: username, password: password)
                            },
                    label: {
                        Text("Sign In")
                            .modifier(ButtonModifier())
                    }
                )
                Spacer()
            }
            .padding(.horizontal, .horizontalPadding)
        }
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }

}

private extension LoginView {
    var loginStateUpdate: AnyPublisher<AppState.LoginState, Never> {
        injected.appState.updates(for: \.loginState)
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().inject(.preview)
            .environment(\.locale, .init(identifier: "ko"))
    }
}
#endif
