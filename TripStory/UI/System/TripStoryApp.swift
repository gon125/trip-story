//
//  TripStoryApp.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import SwiftUI
import Combine
import EnvironmentOverrides

typealias NotificationPayload = [AnyHashable: Any]
typealias FetchCompletion = (UIBackgroundFetchResult) -> Void

class AppDelegate: NSObject, UIApplicationDelegate {
    //func application
}

@main
struct TripStoryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    let environment: AppEnvironment
    var systemEventsHandler: SystemEventsHandler?
    
    init() {
        environment = AppEnvironment.bootstrap()
        systemEventsHandler = environment.systemEventsHandler
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().inject(environment.container)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active: systemEventsHandler?.sceneDidBecomeActive()
            case .inactive: systemEventsHandler?.sceneWillResignActive()
            case .background: return
            @unknown default: return
            }
        }
    }
    
    
}
