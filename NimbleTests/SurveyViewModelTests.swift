//
//  SurveyViewModelTests.swift
//  NimbleTests
//
//  Created by Abdul Rahim on 15/12/21.
//

import XCTest

@testable import Nimble

class SurveyViewModelTests: XCTestCase {
    
    private var apiClient: APIMockResources?
    
    override func setUp() {
        super.setUp()
        apiClient = APIMockResources()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    //MARK: testing survey view model
    
    func test_survey_data_fetch() {
        let expectation = self.expectation(description: "Auth Response Parse Expectation")
        
        apiClient?.requestSurveys(completion: { res in
            XCTAssertNotNil(res)
            XCTAssertEqual(res?.count, 1)
            XCTAssertEqual(res?.first?.title, "Scarlett Bangkok")
            expectation.fulfill()
        }, failure: { err in
            XCTAssertNil(err)
        })
        wait(for: [expectation], timeout: 5)
    }
    
    func test_user_profile_data_fetch() {
        let expectation = self.expectation(description: "Auth Response Parse Expectation")
        
        apiClient?.requestUserProfile(completion: { res in
            XCTAssertNotNil(res)
            XCTAssertEqual(res?.email, "hjhjhj@gmail.com")
            XCTAssertEqual(res?.avatarURL, "https://api.adorable.io/avatar/hjhjhj@gmail.com")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }
    
}
