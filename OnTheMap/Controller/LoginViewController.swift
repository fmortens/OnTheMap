//
//  ViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 06/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class LoginViewController: CustomViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.scale(factor: 5)
        
        self.usernameTextField.delegate = textFieldDelegate
        self.passwordTextField.delegate = textFieldDelegate
        
        // Adjust view for keyboard
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(InformationPostingViewController.keyboardWillShow),
            name: UIResponder.keyboardDidShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(InformationPostingViewController.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    func handleLoginResponse(success: Bool, error: ErrorType?) {
        
        if success {
            if let accountKey = UdacityClient.Auth.account?.key {
                UdacityClient.getPublicUserData(userId: accountKey, completion: handleGetPublicUserData(success:error:))
            }
            
        } else {
            activityIndicator.stopAnimating()
            
            var errorMessage = ErrorType.Unknown.rawValue
            
            if let error = error {
                errorMessage = error.rawValue
            }
            
            alertUser(
                title: "Login Failed",
                message: errorMessage
            )
        }
    }

    func handleGetPublicUserData(success: Bool, error: ErrorType?) {
        
        if success {
            ParseClient.loadStudentLocations(completion: handleStudentLocationsResult(success:error:))
        } else {
            var errorMessage = ErrorType.Unknown.rawValue
            
            if let error = error {
                errorMessage = error.rawValue
            }
            
            alertUser(
                title: "Data fetch failed",
                message: errorMessage
            )
        }
        
    }
    
    override func handleStudentLocationsResult(success: Bool, error: ErrorType?) {
        activityIndicator.stopAnimating()
        
        if success {
            self.performSegue(withIdentifier: "successfulLogin", sender: nil)
        } else {
            alertUser(
                title: "Login Failed",
                message: error!.rawValue
            )
        }
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        
        if let username = usernameTextField.text, let password = passwordTextField.text {
            activityIndicator.startAnimating()
            
            UdacityClient.login(
                username: username,
                password: password,
                completion: handleLoginResponse(success:error:)
            )
        }
    }
    
    @IBAction func didTapSignupButton(_ sender: Any) {
        UIApplication.shared.open(UdacityClient.Endpoints.signup.url)
    }
}
