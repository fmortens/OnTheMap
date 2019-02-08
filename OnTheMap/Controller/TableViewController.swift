//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 07/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
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
    func requestData() {
        ParseClient.loadStudentLocations(completion: handleStudentLocationsResult)
    }
    
    func handleStudentLocationsResult(success: Bool, error: Error?) {
        let deadline = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
            self.refreshControl.endRefreshing()
        })
        
        self.tableView.reloadData()
    }
    
    @IBAction func didTapRefreshButton(_ sender: Any) {
        requestData()
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        print("ADD PIN - TODO!")
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.studentInformationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentInformationTableViewCell")!
        
        let studentInformation = DataModel.studentInformationList[indexPath.row]
        
        cell.textLabel?.text = "\(studentInformation.firstName ?? "") \(studentInformation.lastName ?? "")"
        cell.imageView?.image = UIImage(named: "icon_pin")
        
//        if let posterPath = movie.posterPath {
//            TMDBClient.downloadPosterImage(posterPath: posterPath) { (data, error) in
//                guard let data = data else {
//                    return
//                }
//
//                let image = UIImage(data: data)
//                cell.imageView?.image = image
//                cell.setNeedsLayout()
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndex = indexPath.row
//        performSegue(withIdentifier: "showDetail", sender: nil)
        
        print("row \(indexPath.row) was tapped")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
