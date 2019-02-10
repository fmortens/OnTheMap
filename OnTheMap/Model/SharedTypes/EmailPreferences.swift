//
//  EmailPreferences.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct EmailPreferences: Codable {
    let okUserResearch: Bool?
    let masterOk: Bool?
    let okCourse: Bool?
    
    enum CodingKeys: String, CodingKey {
        case okUserResearch = "ok_user_research"
        case masterOk = "master_ok"
        case okCourse = "ok_course"
    }
    
}
