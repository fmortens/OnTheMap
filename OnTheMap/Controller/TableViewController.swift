//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 07/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class TableViewController: CustomViewController {
    
    @IBOutlet var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.tintColor = .red
        
        refreshControl.addTarget(
            self,
            action: #selector(requestData),
            for: .valueChanged
        )
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // We should not need to load data yet since login loaded it for us. User can request new though.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @objc
    override func requestData() {
        ParseClient.loadStudentLocations(completion: handleStudentLocationsResult)
    }
    
    override func handleStudentLocationsResult(success: Bool, error: Error?) {
        
        if success {
            let deadline = DispatchTime.now() + .milliseconds(500)
            DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
                self.refreshControl.endRefreshing()
            })
            
            self.tableView.reloadData()
        } else {
            alertUser(
                title: "Network failure",
                message: "Could not fetch location data. Please try again."
             )
        }
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
}
