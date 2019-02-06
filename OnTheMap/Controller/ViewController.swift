//
//  ViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 06/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameTextField.text = "fmortens@me.com"
        passwordTextField.text = "blubb"
    }
    
    func handleLoginResponse(success: Bool, error: String?) {
        
        if let error = error {
            let alertVC = UIAlertController(title: "Login Failed", message: error, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            show(alertVC, sender: nil)
        } else {
            
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
    
}

