//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Adarsh A on 09/09/22.
//

import XCTest

class MoviesUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchEnvironment = ["MOVIE_API_URL":ProcessInfo.processInfo.environment["MOVIE_API_URL"]!]
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
