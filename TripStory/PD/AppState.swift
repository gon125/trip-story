//
//  AppState.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

struct AppState: Equatable {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
    var loginState: LoginState = .notRequested
    // var permissions = Permissions()
}

extension AppState {
    struct UserData: Equatable {
    }
}

extension AppState {
    struct ViewRouting: Equatable {
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: Double = 0
    }
}

extension AppState {
    struct Permissions: Equatable {
    }
}

extension AppState {
    enum LoginState: Equatable {
        static func == (lhs: AppState.LoginState, rhs: AppState.LoginState) -> Bool {
            switch (lhs, rhs) {
            case (.notRequested, .notRequested): return true
            case (.isInProgress, .isInProgress): return true
            case (.sucess, .sucess): return true
            case let (.failed(lhsE), .failed(rhsE)): return lhsE.localizedDescription == rhsE.localizedDescription
            default: return false
            }
        }

        case notRequested
        case isInProgress
        case sucess
        case failed(LoginError)
    }
}

// func == (lhs: AppState, rhs: AppState) -> Bool {
//
// }

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
