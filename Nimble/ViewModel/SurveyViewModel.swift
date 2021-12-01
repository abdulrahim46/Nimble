//
//  SurveyViewModel.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import Foundation
import Alamofire

class SurveyViewModel {
    
    init() {
        
    }
    
    let sessionManager: Session = {
      //2
      let configuration = URLSessionConfiguration.af.default
      //3
      configuration.timeoutIntervalForRequest = 30
      //4
      return Session(configuration: configuration)
    }()
    
    
    func getUserProfile(completion: @escaping (UserProfile?) -> ()) {
        let credential = LoginSession.share.credential
        let authenticator = OAuthenticator()
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        let group = DispatchGroup()
        
        group.enter()
        let profileURLRequest = URLRequest(url: URL(string: "https://survey-api.nimblehq.co/api/v1/me")!)
        sessionManager.request(profileURLRequest, interceptor: interceptor)
            .validate()
            .responseDecodable(of: ResponseData<UserProfile>.self) { (response) in
                print(response.response)
                print(response.request)
                switch response.result {
                case .success(let responseData):
                    completion(responseData.data)

                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
    }
    
    func getSurveyList(completion: @escaping ([Survey]?) -> ()) {
        let credential = LoginSession.share.credential
        let authenticator = OAuthenticator()
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
//        let session = Session()
//        let configuration = URLSessionConfiguration.af.default
//         //3
//         configuration.timeoutIntervalForRequest = 30
        let group = DispatchGroup()
        
        group.enter()
        let surveyListURLRequest = URLRequest(url: URL(string: "https://survey-api.nimblehq.co/api/v1/surveys?page[number]=1&page[size]=2")!)
        sessionManager.request(surveyListURLRequest, interceptor: interceptor)
            .validate()
            .responseJSON(completionHandler: { res in
                print(res.result)
            })
            .responseDecodable(of: ResponseData<[Survey]>.self) { (response) in
                print("failoojojjojo\(response.result)")
                print(response.request)
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


