//
//  PutLocationResponse.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct PutLocationResponse: Codable {
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case updatedAt
    }
}
