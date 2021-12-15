//
//  SurveyViewModel.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import Foundation
import Alamofire

class SurveyViewModel {
    
    //MARK:- properties
    
    var apiResource: DataProvider
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
    }
    
    // Get user profile data
    func getUserProfile(completion: @escaping (UserProfile?) -> ()) {
        apiResource.requestUserProfile(completion: { result in
            if let result = result {
                completion(result)
            } else {
                // TODO: error handling for nil
            }
        })
    }
    
    // get survey data from server
    func getSurveyList(completion: @escaping ([Survey]?) -> ()) {
        apiResource.requestSurveys(completion: { result in
            if let result = result {
                completion(result)
            } else {
                // TODO: error handling for nil
            }
        }, failure: { fail in
            if let fail = fail {
                print(fail)
            }
        })
    }
}


