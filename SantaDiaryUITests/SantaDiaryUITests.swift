//
//  SantaDiaryUITests.swift
//  SantaDiaryUITests
//
//  Created by Brian Veitch on 12/23/21.
//

import XCTest

class SantaDiaryUITests: XCTestCase {
    
    private var userDefaults: UserDefaults!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testPasscodeEnteredIncorrectly() throws {
        
//        let app = XCUIApplication()
//        app.launch()
//        
//        print(app.debugDescription)
//
//        app.navigationBars["List of Profiles"].buttons["Item"].tap()
//
//        app/*@START_MENU_TOKEN@*/.buttons.containing(.staticText, identifier:"Done").element.tap()/*[[".otherElements[\"SCLAlertView\"].buttons[\"Done\"]",".tap()",".press(forDuration: 0.8);",".buttons.containing(.staticText, identifier:\"Done\").element"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
//     
//        let textField = app.children(matching: .window).element(boundBy: 0)
//        textField.typeText("1111")
//
//        let confirmYourPasswordTextField = app/*@START_MENU_TOKEN@*/.textFields["Confirm your password"]/*[[".otherElements[\"SCLAlertView\"].textFields[\"Confirm your password\"]",".textFields[\"Confirm your password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        confirmYourPasswordTextField.tap()
//        confirmYourPasswordTextField.typeText("11111")
//        app/*@START_MENU_TOKEN@*/.buttons["Confirm"]/*[[".otherElements[\"SCLAlertView\"].buttons[\"Confirm\"]",".buttons[\"Confirm\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        XCTAssertTrue(confirmYourPasswordTextField.exists)
//         
    }
    
    func testPasscodeEnteredCorrectly() throws {
        
//        let app = XCUIApplication()
//        app.launch()
//
//        app.navigationBars["List of Profiles"].buttons["Item"].tap()
//
//        app/*@START_MENU_TOKEN@*/.buttons.containing(.staticText, identifier:"Done").element/*[[".otherElements[\"SCLAlertView\"].buttons[\"Done\"]",".buttons.containing(.staticText, identifier:\"Done\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        let textField = app.children(matching: .window).element(boundBy: 0)
//        textField.typeText("1111")
//
//        let confirmYourPasswordTextField = app/*@START_MENU_TOKEN@*/.textFields["Confirm your password"]/*[[".otherElements[\"SCLAlertView\"].textFields[\"Confirm your password\"]",".textFields[\"Confirm your password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        confirmYourPasswordTextField.tap()
//        confirmYourPasswordTextField.typeText("1111")
//        app/*@START_MENU_TOKEN@*/.buttons["Confirm"]/*[[".otherElements[\"SCLAlertView\"].buttons[\"Confirm\"]",".buttons[\"Confirm\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//        XCTAssertFalse(confirmYourPasswordTextField.exists)
         
    }
}


extension XCUIApplication {
    func removeParentalPassword() {
        launchArguments += ["-"]
    }
}
