//
//  Errors.swift
//  TripStory
//
//  Created by Gon on 2021/01/12.
//

enum LoginError: Error, CustomStringConvertible {

    case invalidUsername
    case invalidPassword

    var description: String {
        switch self {
        case .invalidUsername: return "Invalid Username"
        case .invalidPassword: return "Invalid Password"
        }
    }

}
