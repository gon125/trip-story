//
//  AuthenticationService.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//
import Combine

protocol AuthenticationService {
    func login(username: String, password: String) -> AnyPublisher<LoginState, Never>
    func signup(username: String, password: String) -> AnyPublisher<SignupState, Never>
    func isUserLoggedIn() -> AnyPublisher<Bool, Never>
    func logout() -> AnyPublisher<Bool, Never>
}

struct DefaultAuthenticationService: AuthenticationService {

    let repository: AuthenticationRepository

    func login(username: String, password: String) -> AnyPublisher<LoginState, Never> {
        repository.createToken(with: username, password: password)
            .map { result in
                switch result {
                case .success: return LoginState.success
                case let .failure(authError): return LoginState.failed(LoginError.externalError(authError.description))
                }
            }
            .eraseToAnyPublisher()

    }

    func logout() -> AnyPublisher<Bool, Never> {
        repository.deleteToken()
    }

    func signup(username: String, password: String) -> AnyPublisher<SignupState, Never> {
        Just(SignupState.failed(.invalidPassword(.empty))).eraseToAnyPublisher()
    }

    func isUserLoggedIn() -> AnyPublisher<Bool, Never> {
        repository.getToken()
            .map { token in
                token == nil ? false : true
            }
            .eraseToAnyPublisher()
    }

 }

 #if DEBUG
 struct StubAuthenticationService: AuthenticationService {
    func logout() -> AnyPublisher<Bool, Never> {
        Just(false)
            .eraseToAnyPublisher()
    }

    func isUserLoggedIn() -> AnyPublisher<Bool, Never> {
        Just(false)
            .eraseToAnyPublisher()
    }

    func login(username: String, password: String) -> AnyPublisher<LoginState, Never> {
        Just(LoginState.failed(.externalError("test"))).eraseToAnyPublisher()
    }

    func signup(username: String, password: String) -> AnyPublisher<SignupState, Never> {
        Just(SignupState.failed(.invalidPassword(.empty))).eraseToAnyPublisher()
    }
 }
 #endif
