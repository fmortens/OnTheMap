//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 09/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit
import CoreLocation

class InformationPostingViewController: UIViewController {
    
    @IBOutlet weak var locationTextInput: UITextField!
    @IBOutlet weak var linkTextInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        print("addLocationViewController")
    }
    
    func handleGeocodeAddress(placeMark: [CLPlacemark]?, error: Error?) {
        guard let placeMark = placeMark else {
            print("COULD NOT RESOLVE LOCATION!")
            let alertVC = UIAlertController(title: "Error", message: "Could not resolve location!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            
            return
        }
        
        print("\(String(describing: placeMark))")
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
    
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func didTapFindLocationButton(_ sender: Any) {
        
        if let addressString = self.locationTextInput.text,
           let linkText = self.linkTextInput.text {
            
            print("FIND LOCATION")
            
            let errorMessage = addressString == "" ? "Missing address" : linkText == "" ? "Missing link" : ""
            
            if errorMessage != "" {
                print("Something is wrong")
                
                
                let alertVC = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                
                
            } else {
                print("we are good")
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(addressString, completionHandler: handleGeocodeAddress(placeMark:error:))
            }
        }
    }
}
