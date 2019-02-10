//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 09/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class InformationPostingViewController: UIViewController {
    
    @IBOutlet weak var locationTextInput: UITextField!
    @IBOutlet weak var linkTextInput: UITextField!
    
    var activeField: UITextField?
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.locationTextInput.delegate = textFieldDelegate
        self.linkTextInput.delegate = textFieldDelegate
        
        if (DataModel.studentInformation?.objectId != nil) {
            self.locationTextInput.text = DataModel.studentInformation?.mapString
            self.linkTextInput.text = DataModel.studentInformation?.mediaURL
        }
        
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
        
        if let mapString = self.locationTextInput.text, let mediaUrl = self.linkTextInput.text {
            
             print("BEFORE: \(String(describing: DataModel.studentInformation))")
            
            // Preserve objectId to be able to update rather than post new
            let objectId = DataModel.studentInformation?.objectId
            
            // Store the data into DataModel
            DataModel.studentInformation = StudentInformation(
                firstName: DataModel.publicUserData!.firstName!,
                lastName: DataModel.publicUserData!.lastName!,
                latitude: placeMark[0].location!.coordinate.latitude,
                longitude: placeMark[0].location!.coordinate.longitude,
                mapString: mapString,
                mediaURL: mediaUrl,
                uniqueKey: UdacityClient.Auth.account!.key,
                objectId: objectId
            )
            
            print("AFTER: \(String(describing: DataModel.studentInformation))")
            
        }
        
        self.performSegue(withIdentifier: "addLocationMap", sender: nil)
        
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        
        // Delete data
        DataModel.studentInformation = nil
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
                geocoder.geocodeAddressString(
                    addressString,
                    completionHandler: handleGeocodeAddress(placeMark:error:)
                )
            }
        }
    }
}

class TextFieldDelegate : NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
