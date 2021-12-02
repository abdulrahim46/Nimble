//
//  ViewController.swift
//  Nimble
//
//  Created by Abdul Rahim on 27/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            let clearPlaceHolderText = NSAttributedString(string: "Email",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.3)])
            
            emailTextField.attributedPlaceholder = clearPlaceHolderText
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            let clearPlaceHolderText = NSAttributedString(string: "Password",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.3)])
            
            passwordTextField.attributedPlaceholder = clearPlaceHolderText
        }
    }
    
    let viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func emailTextDidChanged(_ sender: UITextField) {
        enableLoginButton()
    }
    
    @IBAction func passwordTextDidChanged(_ sender: UITextField) {
        enableLoginButton()
    }
    
    func enableLoginButton() {
       
    }
    
    
    @IBAction func loginDidTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.getAccessToken(email: email , password: password, completion: { [weak self] res in
                print(res)
                if res {
                    DispatchQueue.main.async {
                        self?.showSurveyList()
                    }
                }
            })
        }
    }
    
    
    func showSurveyList() {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SurveyContainerVC") as! SurveyContainerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

