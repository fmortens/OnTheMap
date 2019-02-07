//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 06/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: Udacity
    
    init(username: String, password: String) {
        self.udacity = Udacity(username: username, password: password)
    }
}

struct Udacity: Codable {
    let username: String
    let password: String
}
