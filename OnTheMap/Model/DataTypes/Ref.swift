//
//  Ref.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct Ref: Codable {
    let ref: String?
    let key: String?
    
    enum CodingKeys: String, CodingKey {
        case ref
        case key
    }
}
