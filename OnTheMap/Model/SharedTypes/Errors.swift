//
//  Errors.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 10/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

enum ErrorType: String {
    case LoginFailure = "Username or password is incorrect. Please try again."
    case NetworkError = "A network error has occurred. Please try again."
    case DecodeError = "Could not read received data"
    case PostError = "Could not send data"
    case PutError = "Could not update data"
    case Unknown = "An unknown error has occurred"
}
