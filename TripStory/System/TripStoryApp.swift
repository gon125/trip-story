//
//  TripStoryApp.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import SwiftUI
import Combine
import EnvironmentOverrides

@main
struct TripStoryApp: App {
    
    let environment = AppEnvironment.bootstrap()
    
    var body: some Scene {
        WindowGroup {
            ContentView().inject(environment.container)
        }
    }
    
}
