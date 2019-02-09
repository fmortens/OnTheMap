//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 09/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class InformationPostingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        print("addLocationViewController")
    }
    
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
