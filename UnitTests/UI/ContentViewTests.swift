//
//  ContentViewTests.swift
//  UnitTests
//
//  Created by Gon on 2021/01/09.
//

import XCTest
import ViewInspector

@testable import TripStory

extension ContentView: Inspectable { }
extension StartView: Inspectable { }

final class ContentViewTests: XCTestCase {

    func test_content_for_tests() throws {
        let sut = ContentView(isRunningTests: true)
        XCTAssertNoThrow(try sut.inspect().group().text(0))
    }

    func test_content_for_build() throws {
        let sut = ContentView(isRunningTests: false)
        XCTAssertNoThrow(try sut.inspect().group().zStack(0).anyView(0))
    }
}
