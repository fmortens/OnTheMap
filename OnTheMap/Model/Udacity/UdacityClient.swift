//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 06/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

class UdacityClient {
    
    struct Auth {
        static var registered = false
        static var accountKey = ""
        static var sessionId = ""
        static var sessionExpiration = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com"
        
        case login
        
        var stringValue: String {
            switch self {
                
            case .login:
                return Endpoints.base + "/v1/session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, LoginErrorType?) -> Void) {
        
        let body = LoginRequest(username: username, password: password)
        
        var request = URLRequest(url: Endpoints.login.url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                  completion(false, LoginErrorType.NetworkError)
                }
                return
            }
            
            // skipping the 5 first characters in the data, for some security by obscurity reason
            let newData = data.subdata(in: 5..<data.count)
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(LoginResponse.self, from: newData)
                print(responseObject)
                
                if responseObject.error != nil {
                    DispatchQueue.main.async {
                        completion(false, LoginErrorType.WrongCredentials)
                    }
                }
                
                DispatchQueue.main.async {
                  completion(true, nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                  completion(false, LoginErrorType.Unknown)
                }
            }
        }
        
        task.resume()
        
    }
    
}
