//
//  ViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 06/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Remember to remove these before submitting too late.
        usernameTextField.text = "fmortens@me.com"
        passwordTextField.text = "blubb"
    }
    
    func handleLoginResponse(success: Bool, error: LoginErrorType?) {
        
        if success {
            
            if let accountKey = UdacityClient.Auth.account?.key {
                UdacityClient.getPublicUserData(userId: accountKey, completion: handleGetPublicUserData(success:error:))
            }
        
        } else {
            var errorMessage = LoginErrorType.Unknown.rawValue
            
            if let error = error {
                errorMessage = error.rawValue
            }
            
            let alertVC = UIAlertController(title: "Login Failed", message: errorMessage, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            show(alertVC, sender: nil)
        }
    }

    func handleGetPublicUserData(success: Bool, error: NetworkErrorType?) {
        if success {
            
            ParseClient.loadStudentLocations(completion: handleStudentLocationsResult(success:error:))
            
            
        } else {
            var errorMessage = "Ok, something weird is goind on."
            
            if let error = error {
                errorMessage = error.rawValue
            }
            
            let alertVC = UIAlertController(title: "Data fetch failed", message: errorMessage, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            show(alertVC, sender: nil)
        }
    }
    
    func handleStudentLocationsResult(success: Bool, error: Error?) {
        if success {
            self.performSegue(withIdentifier: "successfulLogin", sender: nil)
        } else {
            let alertVC = UIAlertController(title: "Login Failed", message: (error as! String), preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            show(alertVC, sender: nil)
        }
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        
        if let username = usernameTextField.text, let password = passwordTextField.text {
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

