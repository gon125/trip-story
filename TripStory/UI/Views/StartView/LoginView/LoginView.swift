//
//  LoginView.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI
import Combine

struct LoginView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.major.ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()

                TextField("UserID", text: $viewModel.username)
                    .modifier(
                        TextFieldModifier(
                            isValid: $viewModel.isValidUsername,
                            description: $viewModel.usernameStateString
                        )
                    )
                Spacer().frame(height: 40)
                SecureField("Password", text: $viewModel.password)
                    .modifier(
                        TextFieldModifier(
                            isValid: $viewModel.isValidPassword,
                            description: $viewModel.passwordStateString
                        )
                    )

                Spacer().frame(height: 20)
                HStack { Spacer()
                    NavigationLink(
                        destination: FindPasswordView(username: $viewModel.username)) {
                        Text("Forgot password?")
                            .modifier(TextButtonModifier())
                    }

                }
                Spacer().frame(height: 60)
                Button(
                    action: { viewModel.login() },
                    label: {
                        LoadingButtonView("Sign In", isLoading: $viewModel.isLoading)
                    }
                )
                .disabled(viewModel.isLoading || !viewModel.isLoginable)
                Spacer()
            }
            .padding(.horizontal, .horizontalPadding)
        }
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }

}

extension LoginView {
    class ViewModel: ObservableObject {
        @Published var username = ""
        @Published var password = ""
        @Published var usernameStateString = ""
        @Published var passwordStateString = ""
        @Published var isLoginable = false
        @Published var isLoading = false
        @Published var isValidUsername = false
        @Published var isValidPassword = false
        private let interactor: LoginInteractor
        private let appState: Store<AppState>

        init(interactor: LoginInteractor, appState: Store<AppState>) {
            self.interactor = interactor
            self.appState = appState
            interactor.validationState(username: $username)
                .map { $0.description }
                .assign(to: &$usernameStateString)
            interactor.validationState(username: $username)
                .map { $0 == .valid }
                .assign(to: &$isValidUsername)
            interactor.validationState(password: $password)
                .map { $0.description }
                .assign(to: &$passwordStateString)
            interactor.validationState(password: $password)
                .map { $0 == .valid }
                .assign(to: &$isValidPassword)
            interactor.isLoginable(with: $username, $password)
                .assign(to: &$isLoginable)
            appState.updates(for: \.loginState)
                .map { $0 == .isInProgress}
                .assign(to: &$isLoading)

        }

        func login() {
            interactor.login(username: username, password: password)
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init(interactor: StubLoginInteractor(), appState: .init(.preview))).inject(.preview)
            .environment(\.locale, .init(identifier: "ko"))
    }
}
#endif
