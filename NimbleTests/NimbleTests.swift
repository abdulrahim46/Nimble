//
//  NimbleTests.swift
//  NimbleTests
//
//  Created by Abdul Rahim on 27/11/21.
//

import XCTest
import Alamofire
import Mocker

@testable import Nimble

class NimbleTests: XCTestCase {
    
    // TEsting the login api
    func test_login_api() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let apiEndpoint = URL(string: "https://survey-api.nimblehq.co/api/v1/oauth/token")!
        let requestExpectation = expectation(description: "Login should be success")
        let onRequestExpectation = expectation(description: "Data request should start")
        
        var mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.post: MockedData.loginJSON.data])
        let parameters: [String: String] = ["grant_type": "password",
                                            "email": "kpoolpipat@gmail.com",
                                            "password": "12345678",
                                            "client_id": "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE",
                                            "client_secret": "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"]
        
        mock.onRequest = { request, httpBodyArguments in
            XCTAssertEqual(parameters, httpBodyArguments as? [String: String])
            onRequestExpectation.fulfill()
        }
        mock.register()
        
        sessionManager
            .request(apiEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: ResponseData<LoginCredential>.self) { (response) in
                XCTAssertNil(response.error)
                XCTAssertEqual(response.value?.data.accessToken, "LV-cL5tJ5-dwRSCeCC8nyDLJ5ut6W3f2rsACj104K3Y")
                requestExpectation.fulfill()
            }.resume()
        
        wait(for: [requestExpectation, onRequestExpectation], timeout: 10.0)
    }
    
    // TEsting the survey api
    func test_survey_api() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let apiEndpoint = URL(string: "https://survey-api.nimblehq.co/api/v1/surveys?page[number]=1&page[size]=2")!
        let requestExpectation = expectation(description: "Should success get survey list")
        
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: MockedData.surveyJSON.data])
        mock.register()
        
        sessionManager
            .request(apiEndpoint, method: .get, headers: HTTPHeaders([.authorization(bearerToken: "LV-cL5tJ5-dwRSCeCC8nyDLJ5ut6W3f2rsACj104K3Y")]))
            .responseDecodable(of: ResponseData<[Survey]>.self) { (response) in
                XCTAssertNil(response.error)
                XCTAssertEqual(response.value?.data.count, 2)
                requestExpectation.fulfill()
            }.resume()
        
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    
    // Testing the user profile
    func test_user_profile_data() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "UserProfile", ofType: "json") else {
            fatalError("UserProfileResponse.json not found")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert UserProfileResponse.json to String")
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert UserProfileResponse.json to Data")
        }
        
        let jsonDecoder = JSONDecoder()
        let userProfile = try? jsonDecoder.decode(UserProfile.self, from: jsonData)
        
        XCTAssertEqual(userProfile?.email, "hjhjhj@gmail.com")
    }
    
    // Testing the survey api
    func test_decode_survey_data() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "Survey", ofType: "json") else {
            fatalError("SurveyResponse.json not found")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert SurveyResponse.json to String")
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert SurveyResponse.json to Data")
        }
        
        let jsonDecoder = JSONDecoder()
        let survey = try? jsonDecoder.decode(Survey.self, from: jsonData)
        
        XCTAssertEqual(survey?.title, "Scarlett Bangkok")
    }
    
}
