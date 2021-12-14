//
//  LoginViewModel.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import Foundation
import Alamofire

class LoginViewModel {
    
    var apiResource: DataProvider
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
    }
    
    func getAccessToken(email:  String, password: String, completion: @escaping (LoginCredential) -> ()) {
        apiResource.requestLogin(email: email, password: password, completion: { response in
            if let result = response {
                completion(result)
            }
        })
    }
    
}
