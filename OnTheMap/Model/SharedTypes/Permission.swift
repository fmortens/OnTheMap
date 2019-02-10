//
//  Permission.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct Permission: Codable {
    let derivation: [String]?
    let behavior: String?
    let principalRef: Ref?
    
    enum CodingKeys: String, CodingKey {
        case derivation
        case behavior
        case principalRef = "principal_ref"
    }
}
