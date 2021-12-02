//
//  URLManager.swift
//  Nimble
//
//  Created by Abdul Rahim on 02/12/21.
//

import Foundation

struct URLManager {
    static let kBaseURL = "https://survey-api.nimblehq.co"
    
    
    static let apiPath = "/api/v1"
    
    static func getUrlString(for serviceEnum: ServiceURLType) -> String {
        switch serviceEnum {
        case .login:
            return kBaseURL + apiPath + "/oauth/token"
        case .user:
            return kBaseURL + apiPath + "/me"
        case .surveys:
            return kBaseURL + apiPath + "/surveys?page[number]=1&page[size]=2"
        }
    }
}

enum ServiceURLType {
    case login
    case user
    case surveys
}
