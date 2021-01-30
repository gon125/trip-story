//
//  AuthenticationService.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//
import Combine
import Firebase

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

struct FirebaseAuthenticationService: AuthenticationService {
    func login(username: String, password: String) -> AnyPublisher<LoginState, Never> {
        Future<LoginState, AuthError> { promise in
            Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(AuthError.externalError(error.localizedDescription)))
                    return
                }

                guard authResult != nil else {
                    promise(.failure(AuthError.authResultNil))
                    return
                }
                promise(.success(LoginState.success))
            }
        }
        .catch { (error) -> Just<LoginState> in
            return Just(LoginState.failed(.externalError(error.description)))
        }
        .eraseToAnyPublisher()
    }

    func signup(username: String, password: String) -> AnyPublisher<SignupState, Never> {
        Future<SignupState, AuthError> { promise in
            Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(.externalError(error.localizedDescription)))
                    return
                }

                guard authResult != nil else {
                    promise(.failure(.authResultNil))
                    return
                }
                promise(.success(.success))
            }
        }
        .catch { (error) -> Just<SignupState> in
            return Just(SignupState.failed(.externalError(error.description)))
        }
        .eraseToAnyPublisher()
    }

    func isUserLoggedIn() -> AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
            guard Auth.auth().currentUser != nil else {
                promise(.success(false))
                return
            }
            promise(.success(true))
        }
        .eraseToAnyPublisher()
    }

    func logout() -> AnyPublisher<Bool, Never> {

        Just(())
            .tryMap {
                try Auth.auth().signOut()
                return true
            }
            .replaceError(with: false)
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
