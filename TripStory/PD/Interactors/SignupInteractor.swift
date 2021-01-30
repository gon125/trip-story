//
//  SignupInteractor.swift
//  TripStory
//
//  Created by Gon on 2021/01/17.
//

import Foundation
import Combine

protocol SignupInteractor {
    func signup(with username: String,
                password: String,
                passwordAgain: String,
                signupState: CurrentValueSubject<SignupState, Never>
    )
    func validationState(for username: Published<String>.Publisher) -> AnyPublisher<UsernameState, Never>
    func validationState(for password: Published<String>.Publisher,
                         _ passwordAgain: Published<String>.Publisher
    ) -> AnyPublisher<PasswordState, Never>
    func isSignupable(with username: Published<String>.Publisher,
                      _ password: Published<String>.Publisher,
                      _ passwordAgain: Published<String>.Publisher
    ) -> AnyPublisher<Bool, Never>
}

struct DefaultSignupInteractor: SignupInteractor {
    let service: AuthenticationService
    let cancelBag = CancelBag()

    func signup(with username: String,
                password: String,
                passwordAgain: String,
                signupState: CurrentValueSubject<SignupState, Never>) {
        signupState.send(.isInProgress)
        service.signup(username: username, password: password)
            .sink(receiveValue: { signupState.send($0) })
            .store(in: cancelBag)
    }

    func validationState(for username: Published<String>.Publisher) -> AnyPublisher<UsernameState, Never> {
        isEmpty(username)
            .removeDuplicates()
            .map { isEmpty in
                guard !isEmpty else { return UsernameState.empty }
                return UsernameState.valid
            }
            .eraseToAnyPublisher()
    }

    func validationState(for password: Published<String>.Publisher,
                         _ passwordAgain: Published<String>.Publisher
    ) -> AnyPublisher<PasswordState, Never> {
        Publishers.CombineLatest(isEmpty(password), areEqual(password, passwordAgain))
            .map { isEmpty, areEqual in
                guard !isEmpty else { return PasswordState.empty }
                guard areEqual else { return PasswordState.noMatch }
                return PasswordState.valid
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func isSignupable(with username: Published<String>.Publisher,
                      _ password: Published<String>.Publisher,
                      _ passwordAgain: Published<String>.Publisher
    ) -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(validationState(for: username), validationState(for: password, passwordAgain))
            .map { $0.0 == .valid && $0.1 == .valid }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    private func isEmpty(_ string: Published<String>.Publisher) -> AnyPublisher<Bool, Never> {
        string
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0 == ""}
            .eraseToAnyPublisher()
    }

    private func areEqual(
        _ password: Published<String>.Publisher,
        _ passwordAgain: Published<String>.Publisher
    ) -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(password, passwordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { $0 == $1 }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

}

#if DEBUG
struct StubSignupInteractor: SignupInteractor {
    func signup(with username: String,
                password: String,
                passwordAgain: String,
                signupState: CurrentValueSubject<SignupState, Never>) {
        signupState.send(.success)
    }

    func validationState(for username: Published<String>.Publisher) -> AnyPublisher<UsernameState, Never> {
        Just(UsernameState.empty).eraseToAnyPublisher()
    }

    func validationState(for password: Published<String>.Publisher,
                         _ passwordAgain: Published<String>.Publisher) -> AnyPublisher<PasswordState, Never> {
        Just(PasswordState.noMatch).eraseToAnyPublisher()
    }

    func isSignupable(with username: Published<String>.Publisher,
                      _ password: Published<String>.Publisher,
                      _ passwordAgain: Published<String>.Publisher) -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }

}
#endif
