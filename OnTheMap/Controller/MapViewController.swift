//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 07/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: CustomViewController {
    
    var annotations = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.scale(factor: 5)
        
        updatePins()
    }
    
    func updatePins() {
        self.mapView.removeAnnotations(annotations)
        annotations = [MKPointAnnotation]()
        
        for studentInformation in DataModel.studentInformationList {
            
            if let latitude = studentInformation.latitude, let longitude = studentInformation.longitude {
                // Notice that the float values are being used to create CLLocationDegree values.
                // This is a version of the Double type.
                let lat = CLLocationDegrees(latitude)
                let long = CLLocationDegrees(longitude)
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = studentInformation.firstName
                let last = studentInformation.lastName
                let mediaURL = studentInformation.mediaURL
                
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first ?? "") \(last ?? "")"
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
        }
        
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }
    
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
    override func requestData() {
        activityIndicator.startAnimating()
        ParseClient.loadStudentLocations(completion: handleStudentLocationsResult)
    }
    
    override func handleStudentLocationsResult(success: Bool, error: Error?) {
        activityIndicator.stopAnimating()
        
        if success {
            updatePins()
        } else {
            alertUser(
                title: "Network failure",
                message: "Could not fetch location data. Please try again."
            )
        }
    }
    
}
