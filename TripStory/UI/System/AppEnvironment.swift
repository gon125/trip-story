//
//  AppEnvironment.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import Combine
import Foundation

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store(AppState())
        let session = configuredURLSession()
        let repositories = configuredRepositories(session: session)
        let services = configuredServices(repositories: repositories)
        let interactors = configuredInteractors(appState: appState, services: services)

        let diContainer = DIContainer(appState: appState, interactors: interactors)
        let systemEventHandler = DefaultSystemEventHandler(container: diContainer)
        return AppEnvironment(container: diContainer, systemEventsHandler: systemEventHandler)
    }

    private static func configuredInteractors(
        appState: Store<AppState>,
        services: DIContainer.Services
    ) -> DIContainer.Interactors {
        let signupInteractor = DefaultSignupInteractor()
        let loginInteractor = DefaultLoginInteractor(
            appState: appState,
            authService: services.authenticationService
        )

        return .init(
            signupInteractor: signupInteractor,
            loginInteractor: loginInteractor
        )
    }

    private static func configuredServices(repositories: DIContainer.Repositories) -> DIContainer.Services {
        let authenticationService = DefaultAuthenticationService(repository: repositories.authenticationRepository)
        return .init(authenticationService: authenticationService)
    }

    private static func configuredRepositories(session: URLSession) -> DIContainer.Repositories {

        let baseURL = "http://localhost:3000"
        let authenticationRepository = DefaultAuthenticationRepository(session: session, baseURL: baseURL)
        return .init(authenticationRepository: authenticationRepository)
    }

    private static func configuredURLSession() -> URLSession {
        return URLSession.shared
    }
}
