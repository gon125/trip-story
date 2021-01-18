//
//  SignUpView.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.major.ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()

                TextField("UserID", text: $viewModel.username)
                    .modifier(
                        TextFieldModifier(
                            isValid: $viewModel.isValidUsername ,
                            description: $viewModel.usernameStateString
                        )
                    )
                Spacer().frame(height: 40)
                SecureField("Password", text: $viewModel.password)
                    .modifier(TextFieldModifier(isValid: $viewModel.isValidPassword))
                SecureField("Password Again", text: $viewModel.passwordAgain)
                    .modifier(
                        TextFieldModifier(
                            isValid: $viewModel.isValidPassword ,
                            description: $viewModel.passwordStateString
                        )
                    )

                Spacer().frame(height: 60)
                Button(
                    action: { viewModel.signup() },
                    label: {
                        LoadingButtonView("Sign Up", isLoading: $viewModel.isLoading)
                    }
                )
                .disabled(!viewModel.isSignupable || viewModel.isLoading)
                Spacer()
            }
            .padding(.horizontal, .horizontalPadding)
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }

}

extension SignUpView {
    class ViewModel: ObservableObject {
        @Published var username = ""
        @Published var password = ""
        @Published var passwordAgain = ""
        @Published var usernameStateString = ""
        @Published var passwordStateString = ""
        @Published var isSignupable = false
        private var signupState: CurrentValueSubject<SignupState, Never> = .init(.notRequested)
        @Published var isLoading = false
        @Published var isValidUsername = false
        @Published var isValidPassword = false
        private let interactor: SignupInteractor

        init(interactor: SignupInteractor) {
            self.interactor = interactor
            interactor.validationState(for: $username)
                .map { $0.description }
                .assign(to: &$usernameStateString)
            interactor.validationState(for: $password, $passwordAgain)
                .map { $0.description }
                .assign(to: &$passwordStateString)
            interactor.isSignupable(with: $username, $password, $passwordAgain).assign(to: &$isSignupable)
            signupState
                .map { $0 == .isInProgress}
                .assign(to: &$isLoading)
            interactor.validationState(for: $username)
                .map { $0 == .valid }
                .assign(to: &$isValidUsername)
            interactor.validationState(for: $password, $passwordAgain)
                .map { $0 == .valid }
                .assign(to: &$isValidPassword)

        }

        func signup() {
            interactor.signup(with: username,
                              password: password,
                              passwordAgain: passwordAgain,
                              signupState: signupState
            )
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: .init(interactor: StubSignupInteractor()))
    }
}
