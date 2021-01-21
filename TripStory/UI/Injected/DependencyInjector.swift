//
//  DependencyInjector.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import SwiftUI

// MARK: - DIContainer

struct DIContainer: EnvironmentKey {

    let appState: Store<AppState>
    let interactors: Interactors

    init(appState: Store<AppState>, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }

    init(appState: AppState, interactors: Interactors) {
        self.init(appState: Store(appState), interactors: interactors)
    }

    static var defaultValue: Self { Self.default }
    private static let `default` = Self(appState: AppState(), interactors: .stub)

}

extension DIContainer {
    struct Interactors {
        let signupInteractor: SignupInteractor
        let loginInteractor: LoginInteractor
        let logoutInteractor: LogoutInteractor

        #if DEBUG
        static var stub: Self {
            .init(
                signupInteractor: StubSignupInteractor(),
                loginInteractor: StubLoginInteractor(),
                logoutInteractor: StubLogoutInteractor()
            )
        }
        #endif
    }
}

extension DIContainer {
    struct Services {
        let authenticationService: AuthenticationService

        #if DEBUG
        static var stub: Self {
            .init(authenticationService: StubAuthenticationService())
        }
        #endif
    }
}

extension DIContainer {
    struct Repositories {
        let authenticationRepository: AuthenticationRepository
    }
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: .init(AppState.preview), interactors: .stub)
    }
}
#endif

// MARK: - Injection in the view hierarchy

extension View {

    func inject(_ appState: AppState, _ interactors: DIContainer.Interactors) -> some View {
        let container = DIContainer(appState: .init(appState), interactors: interactors)
        return inject(container)
    }

    func inject(_ container: DIContainer) -> some View {
        return self
            .modifier(RootViewAppearance())
            .environment(\.injected, container)
    }
}
