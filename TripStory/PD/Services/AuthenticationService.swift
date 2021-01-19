//
//  AuthenticationService.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//
import Combine

protocol AuthenticationService {
    func login(username: String, password: String)
//    func validatedPassword(password: Published<String>) -> AnyPublisher<String?, Never>
//    func validatedUsername(username: Published<String>) -> AnyPublisher<String?, Never>

}

struct DefaultAuthenticationService: AuthenticationService {

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

        // appState[\.loginState] = .success
    }

    private func isValidUsername(_ username: String) -> Bool {
        guard username != "" else { return false }
        return true
    }

//    private var isPasswordValid: AnyPublisher<>

    private func isValidPassword(_ password: String) -> Bool {
        guard password != "" else { return false }
        return true
    }

}

#if DEBUG
struct StubAuthenticationService: AuthenticationService {

    func login(username: String, password: String) {
    }

}
#endif
