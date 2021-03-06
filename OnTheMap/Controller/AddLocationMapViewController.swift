//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 09/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationMapViewController: CustomViewController {
    
    var annotation: MKPointAnnotation?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Using DataModel instead of passing via segue since we will POST data later
        activityIndicator.scale(factor: 5)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate =  CLLocationCoordinate2D(
            latitude: DataModel.studentInformation!.latitude!,
            longitude: DataModel.studentInformation!.longitude!
        )
        
        annotation.title = "\(DataModel.studentInformation!.firstName ?? "") \(DataModel.studentInformation!.lastName ?? "")"
        annotation.subtitle = DataModel.studentInformation!.mediaURL
        
        self.mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: CLLocationDistance(exactly: 5000)!,
            longitudinalMeters: CLLocationDistance(exactly: 5000)!
        )
        
        mapView.setRegion(
            mapView.regionThatFits(region),
            animated: true
        )
    }
    
    func handlePostLocation(success: Bool, error: ErrorType?) {
        activityIndicator.stopAnimating()
        
        if success {
            self.presentingViewController?.dismiss(
                animated: true, completion: nil
            )
        } else {
            if let error = error {
                alertUser(
                    title: "Network failure",
                    message: error.rawValue
                )
            } else {
                alertUser(
                    title: "Network failure",
                    message: ErrorType.Unknown.rawValue
                )
            }
        }
    }
    
    @IBAction func didTapFinishButton(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        if (DataModel.studentInformation?.objectId) != nil {
            ParseClient.putStudentLocation(
                location: DataModel.studentInformation!,
                completion: handlePostLocation(success:error:)
            )
        } else {
            ParseClient.postStudentLocation(
                location: DataModel.studentInformation!,
                completion: handlePostLocation(success:error:)
            )
        }
        
    }
}


