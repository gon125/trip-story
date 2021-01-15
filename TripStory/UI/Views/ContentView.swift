//
//  ContentView.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import SwiftUI
import Combine
import EnvironmentOverrides

struct ContentView: View {

    @Environment(\.injected) private var injected: DIContainer
    private let isRunningTests: Bool
    @State private(set) var loginState: AppState.LoginState = .notRequested

    init(isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
        self.isRunningTests = isRunningTests
    }

    var body: some View {
        Group {
            if isRunningTests {
                Text("Running unit tests")
            } else {
                ZStack {
                    self.content
                        .onReceive(loginStateUpdate) { self.loginState = $0 }
                        .attachEnvironmentOverrides()
                    // self.popup
                }

            }
        }
    }

    var onChangeHandler: (EnvironmentValues.Diff) -> Void {
        return { diff in
            if !diff.isDisjoint(with: [.locale, .sizeCategory]) {
                self.injected.appState[\.routing] = AppState.ViewRouting()
            }
        }
    }

    @ViewBuilder private var content: some View {
        switch loginState {
        case .success: MainView()
        default: StartView()
        }
    }

//    @ViewBuilder private var popup: some View {
//        switch loginState {
//        case .isInProgress: ProgressView()
//        default: Text("")
//        }
//    }

}

private extension ContentView {

    var loginStateUpdate: AnyPublisher<AppState.LoginState, Never> {
        injected.appState.updates(for: \.loginState)
    }

//    var notRequesetedView: some View {
//        Login
//    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().inject(.preview)
    }
}
#endif
