//
//  AppState.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

struct AppState: CustomState {
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
        var mainViewRouting = MainView.Routing.home
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
