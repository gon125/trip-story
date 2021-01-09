//
//  TripStoryApp.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import SwiftUI

@main
struct TripStoryApp: App {
    
    let environment = AppEnvironment.bootstrap()
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: environment.container)
        }
    }
    
}
