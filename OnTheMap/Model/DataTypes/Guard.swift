//
//  Guard.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct Guard: Codable {
    let canEdit: Bool?
    let permissions: [Permission]?
    
    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
        case permissions
    }
}

