//
//  Demo500pxUITests.swift
//  Demo500pxUITests
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import XCTest

class Demo500pxUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        for _ in 1...10 {
            let app = XCUIApplication()
            let tablesQuery = app.tables
            tablesQuery.staticTexts["Uncategorized"].tap()
            app.navigationBars["Uncategorized"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Abstract"].tap()
            app.navigationBars["Abstract"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Animals"].tap()
            app.navigationBars["Animals"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Black and White"].tap()
            app.navigationBars["Black and White"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Celebrities"].tap()
            app.navigationBars["Celebrities"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["City and Architecture"].tap()
            app.navigationBars["City and Architecture"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Commercial"].tap()
            app.navigationBars["Commercial"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Concert"].tap()
            app.navigationBars["Concert"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Family"].tap()
            app.navigationBars["Family"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Fashion"].tap()
            app.navigationBars["Fashion"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Film"].tap()
            app.navigationBars["Film"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Fine Art"].tap()
            app.navigationBars["Fine Art"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Food"].tap()
            app.navigationBars["Food"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Journalism"].tap()
            app.navigationBars["Journalism"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            tablesQuery.staticTexts["Landscapes"].tap()
            app.navigationBars["Landscapes"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        }

    }
    
}
