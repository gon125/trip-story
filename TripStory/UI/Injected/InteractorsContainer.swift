//
//  InteractosContainer.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

extension DIContainer {
    struct Interactors {
        let signupInteractor: SignupInteractor
        let loginInteractor: LoginInteractor

        #if DEBUG
        static var stub: Self {
            .init(
                signupInteractor: StubSignupInteractor(),
                loginInteractor: StubLoginInteractor())
        }
        #endif
    }
}
