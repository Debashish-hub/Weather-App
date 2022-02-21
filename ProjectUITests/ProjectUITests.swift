//
//  ProjectUITests.swift
//  ProjectUITests
//
//  Created by comviva on 21/02/22.
//

import XCTest
@testable import Project

class ProjectUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testviews() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        
        let label = app.staticTexts["Weather Forecast"]
        XCTAssert(label.exists)
        
        let enteredcityname = app.textFields["Enter City"]
        XCTAssert(enteredcityname.exists)
        
        
        let checkweatherbtn = app.staticTexts["Check Weather"]
        XCTAssert(checkweatherbtn.exists)
        XCTAssert(checkweatherbtn.isEnabled)
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testvalidcity() throws{
        
        let app = XCUIApplication()
        app.launch()
        //        app.alerts["Allow “Project” to use your location?"].scrollViews.otherElements.buttons["Allow Once"].tap()
        let label = app.staticTexts["Weather Forecast"]
        XCTAssert(label.exists)
        let city="Goa"
        
        
        let enteredcityname = app.textFields["Enter City"]
        let waitingForLocationStaticText = app.staticTexts["Waiting for location!"]
        
        let chechweatherbtn = app.buttons["Check Weather"]
        
        
        enteredcityname.tap()
        enteredcityname.typeText(city)
        let App=app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(chechweatherbtn.isEnabled)
        
        
        chechweatherbtn.tap()
        
        let updatedlabel=app.staticTexts["Your city : Goa"]
        XCTAssert(updatedlabel.exists)
    }
     
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
