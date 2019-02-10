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
        
        requestData()
        
        
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
        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
            self.refreshControl.endRefreshing()
        })

        self.tableView.reloadData()
    }
}
