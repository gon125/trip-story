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
}

struct DefaultAuthenticationService: AuthenticationService {
    let repository: AuthenticationRepository

    func login(username: String, password: String) -> AnyPublisher<LoginState, Never> {
        repository.getToken(with: username, password: password)
            .map { result in
                switch result {
                case .success: return LoginState.success
                case let .failure(authError): return LoginState.failed(LoginError.externalError(authError.description))
                }
            }
            .eraseToAnyPublisher()

    }

    func signup(username: String, password: String) -> AnyPublisher<SignupState, Never> {
        Just(SignupState.failed(.invalidPassword(.empty))).eraseToAnyPublisher()
    }

 }

 #if DEBUG
 struct StubAuthenticationService: AuthenticationService {
    func login(username: String, password: String) -> AnyPublisher<LoginState, Never> {
        Just(LoginState.failed(.externalError("test"))).eraseToAnyPublisher()
    }

    func signup(username: String, password: String) -> AnyPublisher<SignupState, Never> {
        Just(SignupState.failed(.invalidPassword(.empty))).eraseToAnyPublisher()
    }
 }
 #endif
