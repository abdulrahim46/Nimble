//
//  DataProvider.swift
//  Nimble
//
//  Created by Abdul Rahim on 14/12/21.
//

import Foundation
import Alamofire

protocol DataProvider {
    func requestLogin(email: String, password: String, completion: @escaping (LoginCredential?) -> ())
    func requestUserProfile(completion: @escaping (UserProfile?) -> ())
    func requestSurveys(completion: @escaping ([Survey]?) -> (), failure: @escaping (AFError?) -> ())
}
