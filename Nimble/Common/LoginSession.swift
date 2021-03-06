//
//  LoginSession.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import Foundation
import KeychainAccess

class LoginSession {
    private let keychain: Keychain
    private init() { keychain = Keychain(service: "com.nimble-token") }
    
    static let share = LoginSession()
    
    var credential: LoginCredential? {
        get {
            let decoder = JSONDecoder()
            guard let credentialData = keychain[data: "login_credential"],
                  let credential = try? decoder.decode(LoginCredential.self, from: credentialData) else {
                return nil
            }
            
            return credential
        }
        
        set {
            let encoder = JSONEncoder()
            let credentialData = try! encoder.encode(newValue)
            keychain[data: "login_credential"] = credentialData
        }
    }
}
