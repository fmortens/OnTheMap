//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 06/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

enum LoginErrorType: String {
    case WrongCredentials = "Username or password is incorrect"
    case NetworkError = "Could not reach servers"
    case Unknown = "An unknown error has occurred"
}

enum NetworkErrorType: String {
    case GenericError = "An unknown error has occurred"
}

struct LoginResponse: Codable {
    let account: Account?
    let session: Session?
    let status: Int?
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

