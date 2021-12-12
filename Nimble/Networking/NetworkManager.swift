//
//  NetworkManager.swift
//  Nimble
//
//  Created by Abdul Rahim on 08/12/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    typealias APIResponseClosure = (Decodable?) ->()
    typealias APIFailureClosure = (Int?, Decodable?) -> ()
    
    //MARK:- properties
    
    static var interceptor: RequestInterceptor?
    static let credential = LoginSession.share.credential
    static let authenticator = OAuthenticator()
    
    static let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration)
    }()
    
    static func request<T:Codable>(urlName:ServiceURLType, method: HTTPMethod, parameters:[String:Any]?, returnType:T.Type, withResponse requestResponse:@escaping APIResponseClosure, failure:@escaping APIFailureClosure) {
        Connectivity.checkNetworkConnectivity()
        
        // Further Code will execute only when there is Internet Connection Available
        let urlString = URLManager.getUrlString(for: urlName)
        //var urlComponents = URLComponents.init(string: urlString)
        
        if urlName != .login {
            interceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        }
        
        sessionManager.request(urlString, interceptor: interceptor)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success( _):
                    if [200, 201, 202, 203, 204].contains(response.response?.statusCode) {
                        do {
                            //print("response data==========>>>>>\(response.result)")
                            let jsonDecoder = JSONDecoder()
                            let returnObject = try jsonDecoder.decode(returnType, from: response.data!)
                            #if DEBUG
                            debugPrint("result: ==> suceess: \(returnObject)")
                            #endif
                            requestResponse(returnObject)
                        } catch let exception {
                            #if DEBUG
                            debugPrint("Error: ==> Exception: \(exception)")
                            #endif
                            requestResponse(nil)
                        }
                    } else {
                        //print("hgjhjhghjgjhg======\(response.result)")
                    }
                    
                case .failure(let error):
                    print(error)
                    failure(error.responseCode, nil)
                }
            })
    }
}
