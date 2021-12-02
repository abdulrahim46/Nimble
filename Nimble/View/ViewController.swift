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
    
    //MARK:- Action methods
    
    @IBAction func loginDidTapped(_ sender: Any) {
        loadingIndicator.startAnimating()
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.getAccessToken(email: email , password: password, completion: { [weak self] res in
                if res {
                    DispatchQueue.main.async {
                        self?.showSurveyList()
                    }
                }
            })
        }
    }
    
    
    func showSurveyList() {
        loadingIndicator.stopAnimating()
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SurveyContainerVC") as! SurveyContainerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

