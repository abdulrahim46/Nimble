//
//  NimbleUITests.swift
//  NimbleUITests
//
//  Created by Abdul Rahim on 27/11/21.
//

import XCTest

class NimbleUITests: XCTestCase {

    //MARK: UI tests
    
    // Testing the login flow
    func test_login_view_flow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("dev@nimblehq.co")
        
        
        let passwordSecureTextField = XCUIApplication().secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345678")
        app/*@START_MENU_TOKEN@*/.staticTexts["Log in"]/*[[".buttons[\"Log in\"].staticTexts[\"Log in\"]",".staticTexts[\"Log in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    

}
