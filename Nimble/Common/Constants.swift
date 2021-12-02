//
//  Constants.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import Foundation

public struct Constants {
    
    //MARK:- Apikey for requests
    
    struct API {
        static let apiKey = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
        static let secret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
        static let password = "password"
    }
    
    // MARK:- Common Error messages
    
    struct ErrorMessage {
        static let kNoInternetTitle = "No Internet Connectivity!"
        static let kConnectivityError = "Please check your internet connectivity and try again later."
        static let kSomethingWentWrong = "Something went wrong. Please try again later."
        static let kSuccessMessage = "Success"
        static let kEmptyEmail = "Please enter your email"
        static let kPassword = "Please enter your password"
    }
    
}
