//
//  LoginViewModel.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import Foundation
import Alamofire

class LoginViewModel {
    
    
    func getAccessToken(email:  String, password: String, completion: @escaping (Bool) -> ()) {
        Connectivity.checkNetworkConnectivity()
        let parameters: [String: String] = ["grant_type": "password",
                                            "email": email,
                                            "password": password,
                                            "client_id": Constants.API.apiKey,
                                            "client_secret": Constants.API.secret]
        NetworkManager.request(urlName: .login, method: .post, parameters: parameters, returnType: ResponseData<LoginCredential>.self, withResponse: { response in
            completion(true)
        }, failure: { status, error in
            completion(false)
        })
    }
    
//    func getAccessToken(email:  String, password: String, completion: @escaping (Bool) -> ()) {
//        Connectivity.checkNetworkConnectivity()
//        let parameters: [String: String] = ["grant_type": "password",
//                                            "email": email,
//                                            "password": password,
//                                            "client_id": Constants.API.apiKey,
//                                            "client_secret": Constants.API.secret]
//
//        AF.request(URLManager.getUrlString(for: .login), method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate()
//            .responseDecodable(of: ResponseData<LoginCredential>.self) { (response) in
//                switch response.result {
//                case .success(let responseData):
//                    print(responseData)
//                    LoginSession.share.credential = responseData.data
//                    completion(true)
//                case .failure(let error):
//                    print(error)
//                    completion(false)
//                }
//            }
//    }
    
}
