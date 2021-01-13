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
                        .attachEnvironmentOverrides()
                        .onReceive(loginStateUpdate) { self.loginState = $0 }
                    //self.popup
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
    
    private var content: AnyView {
        switch loginState {
        case .sucess: return AnyView(MainView())
        default: return AnyView(StartView())
        }
    }
    
//    private var popup: AnyView {
//        switch viewModel.loginState {
//        case let .failed(error):
//            <#code#>
//        default:
//            <#code#>
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