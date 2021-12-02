//
//  ViewController.swift
//  Nimble
//
//  Created by Abdul Rahim on 27/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK:- View & properties
    let viewModel = LoginViewModel()
    private(set) var loadingIndicator = UIActivityIndicatorView(style: .gray)
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
    
    //MARK:- Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupLoadingIndicator()
        setupKeyboard()
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupKeyboard(){
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        if #available(iOS 14.0, *) {
            bar.items = [.flexibleSpace(),done]
        } else {
            bar.items = [done]
        }
        bar.sizeToFit()
        passwordTextField.inputAccessoryView = bar
        emailTextField.inputAccessoryView = bar
    }
    
    //MARK:- Action methods
    
    @objc func didTapDone(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func loginDidTapped(_ sender: Any) {
        checkValidation()
        loadingIndicator.startAnimating()
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.getAccessToken(email: email , password: password, completion: { [weak self] res in
                if res {
                    DispatchQueue.main.async {
                        self?.showSurveyList()
                    }
                } else  {
                    self?.loadingIndicator.stopAnimating()
                }
            })
        }
    }
    
    func checkValidation() {
        if emailTextField.text?.isEmpty == true && emailTextField.text?.count == 0 {
            Alert.showErrorAlertWithMsg(title: "Error", msg: Constants.ErrorMessage.kEmptyEmail, showOn: self)
            return
        } else if passwordTextField.text?.isEmpty == true && passwordTextField.text?.count == 0 {
            Alert.showErrorAlertWithMsg(title: "Error", msg: Constants.ErrorMessage.kPassword, showOn: self)
            return
        }
    }
    
    
    func showSurveyList() {
        loadingIndicator.stopAnimating()
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SurveyContainerVC") as! SurveyContainerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

