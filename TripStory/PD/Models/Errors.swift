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
    case externalError(String)
}

enum SignupError: CustomError {
    case invalidPassword(PasswordCheck)
    case externalError(String)
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

enum AuthError: CustomError {
    case noMatchingUsername
    case wrongPassword
    case authResultNil
    case externalError(String)
}

enum ImageError: CustomError {
    case notFound
}

extension ImageError {
    var description: String {
        switch self {
        case .notFound: return "Image not found"
        }
    }
}

extension AuthError {
    var description: String {
        switch self {
        case .noMatchingUsername: return "There is no matching Username"
        case .wrongPassword: return "Wrong Password"
        case .authResultNil: return "Auth Result Not Found"
        case let .externalError(errorDescription): return errorDescription
        }
    }
}

extension LoginError {
    var description: String {
        switch self {
        case .invalidUsername: return "Invalid Username"
        case .invalidPassword: return "Invalid Password"
        case let .externalError(errorDescription): return errorDescription
        }
    }
}

extension SignupError {
    var description: String {
        switch self {
        case let .invalidPassword(passwordCheck): return passwordCheck.description
        case let .externalError(errorDescription): return errorDescription
        }
    }
}
