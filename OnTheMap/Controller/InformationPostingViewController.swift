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

class InformationPostingViewController: CustomViewController {
    
    @IBOutlet weak var locationTextInput: UITextField!
    @IBOutlet weak var linkTextInput: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var activeField: UITextField?
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        activityIndicator.scale(factor: 5)
        
        self.locationTextInput.delegate = textFieldDelegate
        self.linkTextInput.delegate = textFieldDelegate
        
        if (DataModel.studentInformation?.objectId != nil) {
            self.locationTextInput.text = DataModel.studentInformation?.mapString
            self.linkTextInput.text = DataModel.studentInformation?.mediaURL
        }
        
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
    
    func handleGeocodeAddress(placeMark: [CLPlacemark]?, error: Error?) {
        
        activityIndicator.stopAnimating()
        
        guard let placeMark = placeMark else {
            alertUser(title: "Error", message: "Could not resolve location!")
            return
        }
        
        if let mapString = self.locationTextInput.text, let mediaUrl = self.linkTextInput.text {
            
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
        }
        
        self.performSegue(withIdentifier: "addLocationMap", sender: nil)
        
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        
        // Delete data
        DataModel.studentInformation = nil
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func didTapFindLocationButton(_ sender: Any) {
        activityIndicator.startAnimating()
        
        if let addressString = self.locationTextInput.text, let linkText = self.linkTextInput.text {
            
            let errorMessage = addressString == "" ? "Missing address" : linkText == "" ? "Missing link" : ""
            
            if errorMessage != "" {
                activityIndicator.stopAnimating()
                alertUser(title: "Error", message: errorMessage)
            } else {
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
