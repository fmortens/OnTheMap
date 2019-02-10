//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 06/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account?
    let session: Session?
    let status: Int?
    let error: String?
}
