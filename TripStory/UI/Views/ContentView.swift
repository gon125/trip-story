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
    @State private(set) var loginState: LoginState = .notRequested

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
        case .success: MainView(viewModel: .init())
        default: StartView()
        }
    }

}

private extension ContentView {

    var loginStateUpdate: AnyPublisher<LoginState, Never> {
        injected.appState.updates(for: \.loginState)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().inject(.preview)
    }
}
#endif
