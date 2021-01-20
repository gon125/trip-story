//
//  States.swift
//  TripStory
//
//  Created by Gon on 2021/01/17.
//

protocol CustomState: Equatable { }

enum LoginState: CustomState {

    case notRequested
    case isInProgress
    case success
    case failed(AuthError)
}

enum SignupState: CustomState {

    case notRequested
    case isInProgress
    case success
    case failed(SignupError)
}

enum PasswordState: CustomState, CustomStringConvertible {
    case valid
    case empty
    case noMatch

    var description: String {
        switch self {
        case .valid: return ""
        case .empty: return "Enter a password."
        case .noMatch: return "Those passwords didin't match. Try again."
        }
    }
}

enum UsernameState: CustomState, CustomStringConvertible {
    case valid
    case empty

    var description: String {
        switch self {
        case .valid: return ""
        case .empty: return "Enter a username."
        }
    }
}
