//
//  AppState.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import SwiftUI

struct AppState: Equatable {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
    //var permissions = Permissions()
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
        var keyboardHeight: CGFloat = 0
    }
}

extension AppState {
    struct Permissions: Equatable {
    }
}

//func == (lhs: AppState, rhs: AppState) -> Bool {
//
//}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif


