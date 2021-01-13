//
//  Helpers.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import Foundation

extension ProcessInfo {
    var isRunningTests: Bool {
        environment["XCTestConfigurationFilePath"] != nil
    }
}
