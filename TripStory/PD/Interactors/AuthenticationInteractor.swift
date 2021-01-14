//
//  AuthenticationInteractor.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import Foundation

protocol AuthenticationInteractor {
    func login(username: String, password: String)

}

struct DefaultAuthenticationInteractor: AuthenticationInteractor {

    let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }

    func login(username: String, password: String) {
        appState[\.loginState] = .isInProgress

        guard isValidUsername(username) else {
            appState[\.loginState] = .failed(LoginError.invalidUsername)
            return
        }

        guard isValidPassword(password) else {
            appState[\.loginState] = .failed(LoginError.invalidPassword)
            return
        }

        appState[\.loginState] = .sucess
    }

    private func isValidUsername(_ username: String) -> Bool {
        guard username != "" else { return false }
        return true
    }

    private func isValidPassword(_ password: String) -> Bool {
        guard password != "" else { return false }
        return true
    }

}

#if DEBUG
struct StubAuthenticationInteractor: AuthenticationInteractor {

    func login(username: String, password: String) {
    }

}
#endif
