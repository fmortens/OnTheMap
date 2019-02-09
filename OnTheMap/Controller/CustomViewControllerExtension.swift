//
//  UIViewControllerExtension.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 07/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

extension CustomViewController {
    
    func handleLogoutResponse(success: Bool) {
        if success {
            self.dismiss(animated: true, completion: nil)
        } else {
            
            let alertVC = UIAlertController(
                title: "Logout Failed",
                message: "Ok, for some weird reason we could not log out. Please try again :/",
                preferredStyle: .alert
            )
            
            alertVC.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil
                )
            )
            
            show(alertVC, sender: nil)
        }
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        
        UdacityClient.logout(completion: handleLogoutResponse)
        
    }
    
    @IBAction func didTapRefreshButton(_ sender: Any) {
        print("didTapRefreshButton")
        self.requestData()
        
    }
    
}

