//
//  Email.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

struct Email: Codable {
    let verificationCodeSent: Bool?
    let verified: Bool?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case verificationCodeSent = "_verification_code_sent"
        case verified = "_verified"
        case address
    }
}
