//
//  Errors.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
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
