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
        let credential = LoginSession.share.credential
        let authenticator = OAuthenticator()
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        let group = DispatchGroup()
        group.enter()
        let profileURLRequest = URLRequest(url: URL(string: URLManager.getUrlString(for: .user))!)
        NetworkManager.request(urlName: .user, method: .get, parameters: nil, returnType: UserProfile.self, withResponse: { response in
            print("response=========\(response)")
            //completion(response)
        }, failure: { status, error in
            //completion(error)
        })
//        sessionManager.request(profileURLRequest, interceptor: interceptor)
//            .validate()
//            .responseDecodable(of: ResponseData<UserProfile>.self) { (response) in
//                switch response.result {
//                case .success(let responseData):
//                    completion(responseData.data)
//
//                case .failure(let error):
//                    print(error)
//                }
//                group.leave()
//            }
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
        NetworkManager.request(urlName: .surveys, method: .get, parameters: nil, returnType: [Survey].self, withResponse: { response in
            //completion(response)
            //completion(response)
            if let response = response as? [Survey] {
                completion(response)
                print("response=========\(response)")
            }
           // print("response=========\(response)")
            //completion(response)
        }, failure: { status, error in
            //completion(error)
        })
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


