//
//  NetworkManager.swift
//  Nimble
//
//  Created by Abdul Rahim on 08/12/21.
//

import Foundation
import Alamofire

class NetworkManager: DataProvider {
    
    //MARK:- properties
    
    var interceptor: RequestInterceptor?
    static let credential = LoginSession.share.credential
    static let authenticator = OAuthenticator()
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration)
    }()
    
    func requestLogin(email: String, password: String, completion: @escaping (LoginCredential?) -> ()) {
        Connectivity.checkNetworkConnectivity()
        let parameters: [String: String] = ["grant_type": "password",
                                            "email": email,
                                            "password": password,
                                            "client_id": Constants.API.apiKey,
                                            "client_secret": Constants.API.secret]
        let group = DispatchGroup()
        group.enter()
        AF.request(URLManager.getUrlString(for: .login), method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: ResponseData<LoginCredential>.self) { (response) in
                switch response.result {
                case .success(let responseData):
                    print(responseData)
                    LoginSession.share.credential = responseData.data
                    completion(responseData.data)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
    }
    
    
    func requestUserProfile(completion: @escaping (UserProfile?) -> ()) {
        let group = DispatchGroup()
        group.enter()
        let profileURLRequest = URLRequest(url: URL(string: URLManager.getUrlString(for: .user))!)
        sessionManager.request(profileURLRequest, interceptor: interceptor)
            .validate()
            .responseDecodable(of: ResponseData<UserProfile>.self) { (response) in
                switch response.result {
                case .success(let responseData):
                    completion(responseData.data)
                    
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
    }
    
    
    func requestSurveys(completion: @escaping ([Survey]?) -> (), failure: @escaping (AFError?) -> ()) {
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
                    failure(error)
                }
                group.leave()
            }
    }
}
