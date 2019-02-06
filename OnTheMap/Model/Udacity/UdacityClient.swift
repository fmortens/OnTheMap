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
    
    class func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        
        let body = LoginRequest(username: username, password: password)
        
        var request = URLRequest(url: Endpoints.login.url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                completion(false, "Network error")
                return
            }
            
            let decoder = JSONDecoder()
            let newData = data.subdata(in: 5..<data.count)
            
            do {
                let responseObject = try decoder.decode(LoginResponse.self, from: newData)
                
                if let error = responseObject.error {
                    
                    DispatchQueue.main.async {
                        completion(false, error)
                    }
                }
                
                DispatchQueue.main.async {
                  completion(true, nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                  completion(false, "Unknown error")
                }
            }
        }
        
        task.resume()
        
    }
    
}
