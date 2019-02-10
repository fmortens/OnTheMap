//
//  CustomViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 09/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    func alertUser(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc
    func requestData() {
        // please override
    }
    
    func handleStudentLocationsResult(success: Bool, error: ErrorType?) {
        // please override
    }
    
}
