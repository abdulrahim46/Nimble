//
//  Alert.swift
//  Nimble
//
//  Created by Abdul Rahim on 02/12/21.
//

import UIKit

//MARK:- General Alert pop up

struct Alert {
    static func showErrorAlertWithMsg(title:String, msg:String, showOn vc: UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.parent?.present(alert, animated: true, completion: nil)
    }
}
