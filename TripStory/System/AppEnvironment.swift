//
//  AppEnvironment.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import Combine

struct AppEnvironment {
    let container: DIContainer
    //let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store(AppState())
        let interactors = configuredInteractors(appState: appState)
        
        
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredInteractors(appState: Store<AppState>) -> DIContainer.Interactors {
        let authenticationInteractor = DefaultAuthenticationInteractor()
        
        return .init(authenticationInteractor: authenticationInteractor)
    }
}
