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
    let status: Int
    let error: String?
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}

/*
 Success:
 
 {
    "account":{
        "registered":true,
        "key":"3903878747"
    },
    "session":{
        "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
        "expiration":"2015-05-10T16:48:30.760460Z"
    }
 }
 
 Failure:
 
 {
   "account": nil,
   "session": nil,
   "status": 403,
   "error": "Account not found or invalid credentials."
 }
 
 */
