//
//  LoginViewModelTests.swift
//  NimbleTests
//
//  Created by Abdul Rahim on 15/12/21.
//

import XCTest

@testable import Nimble

class LoginViewModelTests: XCTestCase {
    
    private var apiClient: APIMockResources?
    
    override func setUp() {
        super.setUp()
        apiClient = APIMockResources()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    //MARK: testing login view model
    
    func test_login_data_fetch() {
        let expectation = self.expectation(description: "Auth Response Parse Expectation")
        
        apiClient?.requestLogin(email: "", password: "", completion: { res in
            //XCTAssertNil((res))
            XCTAssertEqual(res?.accessToken, "LV-cL5tJ5-dwRSCeCC8nyDLJ5ut6W3f2rsACj104K3Y")
            XCTAssertEqual(res?.refreshToken, "8U10pPTY4QmW2DR_Gl4UxO-I2RamQIp5uFkHzgkM2cI")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }
    
}
