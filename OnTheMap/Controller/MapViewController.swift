//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 07/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        ParseClient.loadStudentLocations(completion: handleStudentLocationsResult(success:error:))
    }
    
    func handleStudentLocationsResult(success: Bool, error: Error?) {
        if success {
            print(StudentInformationModel.studentInformationList)
        } else {
            let alertVC = UIAlertController(title: "Login Failed", message: (error as! String), preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            show(alertVC, sender: nil)
        }
    }
    
}
