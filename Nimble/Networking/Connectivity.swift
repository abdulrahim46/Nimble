//
//  Connectivity.swift
//  Nimble
//
//  Created by Abdul Rahim on 02/12/21.
//

import Foundation
import Alamofire

public class Connectivity {
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //checking the network connectivity
    static func checkNetworkConnectivity() {
        // First Check for Internet Connectivity
        // If NO_INTERNET, Fail and Return
        if Connectivity.isConnectedToInternet == false {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            if let topVC = UIApplication.getTopMostViewController() {
                if let _ = topVC as? UIAlertController {
                    return
                }
                Alert.showErrorAlertWithMsg(title: Constants.ErrorMessage.kNoInternetTitle, msg: Constants.ErrorMessage.kConnectivityError, showOn: topVC)
            }
            return
        }
    }
}
