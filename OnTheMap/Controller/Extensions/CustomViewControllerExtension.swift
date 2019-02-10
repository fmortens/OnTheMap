//
//  UIViewControllerExtension.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 07/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit
import MapKit

extension CustomViewController: MKMapViewDelegate {
    
    func handleLogoutResponse(success: Bool) {
        if success {
            self.dismiss(animated: true, completion: nil)
        } else {
            
            let alertController = UIAlertController(
                title: "Logout Failed",
                message: "Ok, for some weird reason we could not log out. Please try again :/",
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
    }
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
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
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        UdacityClient.logout(completion: handleLogoutResponse)
    }
    
    @IBAction func didTapRefreshButton(_ sender: Any) {
        self.requestData()
    }
    
}

