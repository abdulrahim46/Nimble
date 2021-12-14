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
    
    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.timeoutIntervalForRequest = 30
      return Session(configuration: configuration)
    }()
    
    // Get user profile data
    func getUserProfile(completion: @escaping (UserProfile?) -> ()) {
        Connectivity.checkNetworkConnectivity()
    }
    
    // get survey data from server
    func getSurveyList(completion: @escaping ([Survey]?) -> ()) {
        Connectivity.checkNetworkConnectivity()
        let credential = LoginSession.share.credential
        let authenticator = OAuthenticator()
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        let group = DispatchGroup()
        group.enter()
        let surveyListURLRequest = URLRequest(url: URL(string: URLManager.getUrlString(for: .surveys))!)
        sessionManager.request(surveyListURLRequest, interceptor: interceptor)
            .validate()
            .responseDecodable(of: ResponseData<[Survey]>.self) { (response) in
                switch response.result {
                case .success(let responseData):
                    completion(responseData.data)

                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
    }
}


