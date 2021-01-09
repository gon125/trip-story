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
    
    private let container: DIContainer
    //private let
    private let isRunningTests: Bool

    init(container: DIContainer, isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
        self.container = container
        self.isRunningTests = isRunningTests
    }
    
    var body: some View {
        Group {
            if isRunningTests {
                Text("Running unit tests")
            } else {
                
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
#endif
