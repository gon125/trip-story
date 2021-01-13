//
//  InteractosContainer.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

extension DIContainer {
    struct Interactors {
        let authenticationInteractor: AuthenticationInteractor
        
        #if DEBUG
        static var stub: Self {
            .init(authenticationInteractor: StubAuthenticationInteractor())
        }
        #endif
    }
}
