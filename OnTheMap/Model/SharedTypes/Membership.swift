//
//  Membership.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct Membership: Codable {
    let current: Bool?
    let groupRef: Ref?
    let creationTime: String?
    let expirationTime: String?
    
    enum CodingKeys: String, CodingKey {
        case current
        case groupRef = "group_ref"
        case creationTime = "creation_time"
        case expirationTime = "expiration_time"
    }
}
