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

class AddLocationMapViewController: UIViewController {
    
    var annotation: MKPointAnnotation?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Using DataModel instead of passing via segue since we will POST data later
        
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
    func handlePostLocation(success: Bool, error: Error?) {
        if success {
            print("SUCCESS")
            
            print("\(String(describing: DataModel.studentInformation))")
            
            self.presentingViewController?.dismiss(
                animated: true, completion: nil
            )

        } else {
            if let error = error {
                print("ERROR \(error)")
            } else {
                print("ERROR UNKNOWN")
            }
            
        }
        
    }
    
    @IBAction func didTapFinishButton(_ sender: Any) {
        
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

extension AddLocationMapViewController: MKMapViewDelegate {
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .blue
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle!, let url = URL(string: toOpen) {
                UIApplication.shared.open(url)
            }
        }
    }
}

