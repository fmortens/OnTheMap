//
//  CustomViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 09/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    @objc
    func requestData() {
        print("Please override")
    }
    
    func handleStudentLocationsResult(success: Bool, error: Error?) {
        print("Please override")
    }
    
}
