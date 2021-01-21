//
//  LogoutInteractor.swift
//  TripStory
//
//  Created by Gon on 2021/01/21.
//

import Foundation
import Combine

protocol LogoutInteractor {
    func logout()
}

struct DefaultLogoutInteractor: LogoutInteractor {
    let appState: Store<AppState>
    let authService: AuthenticationService
    let cancelBag = CancelBag()

    func logout() {
        authService.logout()
            .sink(receiveValue: { isUserloggedOut in
                assert(isUserloggedOut)
                appState[\.loginState] = .notRequested
            })
            .store(in: cancelBag)
    }
}

#if DEBUG
struct StubLogoutInteractor: LogoutInteractor {
    func logout() { }
}
#endif
