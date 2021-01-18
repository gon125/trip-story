//
//  Errors.swift
//  TripStory
//
//  Created by Gon on 2021/01/12.
//

protocol CustomError: Error, Equatable, CustomStringConvertible { }

enum LoginError: CustomError {
    case invalidUsername
    case invalidPassword
}

enum SignupError: CustomError {
    case invalidPassword(PasswordCheck)
    enum PasswordCheck: Error {
        case valid
        case empty
        case noMatch
        case notStrongEnough

        var description: String {
            switch self {
            case .valid: return "valid"
            default: return "false"
            }
        }
    }
}

extension LoginError {
    var description: String {
        switch self {
        case .invalidUsername: return "Invalid Username"
        case .invalidPassword: return "Invalid Password"
        }
    }
}

extension SignupError {
    var description: String {
        switch self {
        case let .invalidPassword(passwordCheck): return passwordCheck.description
        }
    }
}