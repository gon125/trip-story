//
//  SystemEventsHandler.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import Combine
import UIKit

protocol SystemEventsHandler {
    //TODO: - Deep Link
    //func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>)
    func sceneDidBecomeActive()
    func sceneWillResignActive()
    //TODO: Notification features
    //func handlePushRegistration(result: Result<Data, Error>)
    //func appDidReceiveRemoteNotification(payload: NotificationPayload, fetchCompletion: @escaping FetchCompletion)
}

struct DefaultSystemEventHandler: SystemEventsHandler {
    
    let container: DIContainer
    //TODO: add deep link and push notification
    //let deepLinksHandler: DeepLinksHandler
    //let pushNotificationHandler: PushNotificationHandler
    //let pushTokenWebRepository: PushTokenWebRepository
    //private var cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
    }
    
//    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>) {
//        guard let url = urlContexts.first?.url else { return }
//        handle(url: url)
//    }
//
//    private func handle(url: URL) {
//        guard let deepLink = DeepLink(url: url) else { return }
//        deepLinksHandler.open(deepLink: deepLink)
//    }
    
    func sceneDidBecomeActive() {
        container.appState[\.system.isActive] = true
        //TODO: add push notification permission code here
        //container.interactors.
    }
    
    func sceneWillResignActive() {
        container.appState[\.system.isActive] = false
    }
    
//    func handlePushRegistration(result: Result<Data, Error>) {
//        <#code#>
//    }
    
//    func appDidReceiveRemoteNotification(payload: NotificationPayload, fetchCompletion: @escaping FetchCompletion) {
//        <#code#>
//    }
}
