//
//  DeepLinksHandler.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import Foundation

enum DeepLink: Equatable {
    case showTourInfo

    init?(url: URL) {

        // TODO: set some query here

//        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
//              let query = components.queryItems
//        else { return nil }
        return nil
    }
}

protocol DeepLinksHandler {
    func open(deepLink: DeepLink)
}

struct DefaultDeepLinksHandler: DeepLinksHandler {

    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    func open(deepLink: DeepLink) {
        // TODO: add some deeplink work here
//        switch deepLink {
//        case .showTourInfo:
//
//        }
    }
}
