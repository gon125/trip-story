//
//  InteractosContainer.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

extension DIContainer {
    struct Interactors {
        let authenticationInteractor: AuthenticationInteractor
        let signupInteractor: SignupInteractor

        #if DEBUG
        static var stub: Self {
            .init(authenticationInteractor: StubAuthenticationInteractor(), signupInteractor: StubSignupInteractor())
        }
        #endif
    }
}
