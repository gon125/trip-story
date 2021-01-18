//
//  LoginInteractor.swift
//  TripStory
//
//  Created by Gon on 2021/01/17.
//
import Foundation
import Combine

protocol LoginInteractor {
    func login(username: String, password: String)
    func validationState(username: Published<String>.Publisher) -> AnyPublisher<UsernameState, Never>
    func validationState(password: Published<String>.Publisher) -> AnyPublisher<PasswordState, Never>
    func isLoginable(with username: Published<String>.Publisher,
                     _ password: Published<String>.Publisher
    ) -> AnyPublisher<Bool, Never>
}

struct DefaultLoginInteractor: LoginInteractor {

    let appState: Store<AppState>

    func login(username: String, password: String) {
        appState[\.loginState] = .isInProgress
    }

    func validationState(username: Published<String>.Publisher) -> AnyPublisher<UsernameState, Never> {
        isEmpty(username)
            .map { isEmpty in
                guard !isEmpty else { return UsernameState.empty }
                return UsernameState.valid
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func validationState(password: Published<String>.Publisher) -> AnyPublisher<PasswordState, Never> {
        isEmpty(password)
            .map { isEmpty in
                guard !isEmpty else { return PasswordState.empty}
                return PasswordState.valid
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func isLoginable(with username: Published<String>.Publisher,
                     _ password: Published<String>.Publisher
    ) -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(validationState(username: username), validationState(password: password))
            .map { $0.0 == .valid && $0.1 == .valid }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    private func isEmpty(_ string: Published<String>.Publisher) -> AnyPublisher<Bool, Never> {
        string
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0 == "" }
            .eraseToAnyPublisher()
    }

}

#if DEBUG
struct StubLoginInteractor: LoginInteractor {
    func login(username: String, password: String) {
        //
    }

    func validationState(username: Published<String>.Publisher) -> AnyPublisher<UsernameState, Never> {
        isEmpty(username)
            .map { isEmpty in
                guard !isEmpty else { return UsernameState.empty }
                return UsernameState.valid
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func validationState(password: Published<String>.Publisher) -> AnyPublisher<PasswordState, Never> {
        isEmpty(password)
            .map { isEmpty in
                guard !isEmpty else { return PasswordState.empty}
                return PasswordState.valid
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func isLoginable(with username: Published<String>.Publisher,
                     _ password: Published<String>.Publisher
    ) -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(validationState(username: username), validationState(password: password))
            .map { $0.0 == .valid && $0.1 == .valid }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    private func isEmpty(_ string: Published<String>.Publisher) -> AnyPublisher<Bool, Never> {
        string
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0 == "" }
            .eraseToAnyPublisher()
    }
}
#endif
