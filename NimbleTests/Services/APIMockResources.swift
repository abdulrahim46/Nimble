//
//  APIMockResources.swift
//  NimbleTests
//
//  Created by Abdul Rahim on 14/12/21.
//

import Foundation
import Alamofire

@testable import Nimble

class APIMockResources: DataProvider {
    
    
    func requestLogin(email: String, password: String, completion: @escaping (LoginCredential?) -> ()) {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "LoginCredential", ofType: "json") else {
            fatalError("LoginCredential.json not found")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert LoginCredential.json to String")
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert LoginCredential.json to Data")
        }
        
        let jsonDecoder = JSONDecoder()
        let login = try? jsonDecoder.decode(LoginCredential.self, from: jsonData)
        completion(login)
    }
    
    func requestUserProfile(completion: @escaping (UserProfile?) -> ()) {
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
        completion(userProfile)
    }
    
    func requestSurveys(completion: @escaping ([Survey]?) -> (), failure: @escaping (AFError?) -> ()) {
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
        var sArr = [Survey]()
        if let survey = survey {
            sArr.append(survey)
        }
        completion(sArr)
    }
    
    
}

