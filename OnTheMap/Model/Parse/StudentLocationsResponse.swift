//
//  StudentLocationsResult.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 07/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct StudentLocationsResult: Codable {
    
    let results: [StudentInformation]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
