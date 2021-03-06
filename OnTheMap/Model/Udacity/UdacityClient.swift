//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 06/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//


// TODO: ADD METHOD FOR GETTING RANDOM USER INFO


import Foundation

class UdacityClient {
    
    struct Auth {
        static var account: Account? = nil
        static var session: Session? = nil
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com"

        case login
        case signup
        case logout
        case getPublicUserData(String)
        
        var stringValue: String {
            
            switch self {
                case .login, .logout:
                    return Endpoints.base + "/v1/session"
            
                case .signup:
                    return "https://auth.udacity.com/sign-up"
                
            case .getPublicUserData(let userId):
                    return Endpoints.base + "/v1/users/\(userId)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, ErrorType?) -> Void) {
        
        let body = LoginRequest(username: username, password: password)
        
        var request = URLRequest(url: Endpoints.login.url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                  completion(false, ErrorType.NetworkError)
                }
                return
            }
            
            // skipping the 5 first characters in the data, for some security by obscurity reason
            let newData = data.subdata(in: 5..<data.count)
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(LoginResponse.self, from: newData)
                
                if responseObject.error != nil {
                    DispatchQueue.main.async {
                        completion(false, ErrorType.LoginFailure)
                    }
                }
                
                if let session = responseObject.session, let account = responseObject.account {
                    Auth.session = session
                    Auth.account = account
                } else {
                    // I mean, if we can't get session or account something must be wrong
                    DispatchQueue.main.async {
                        completion(false, ErrorType.Unknown)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(true, nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                  completion(false, ErrorType.DecodeError)
                }
            }
        }
        
        task.resume()
        
    }
    
    class func logout(completion: @escaping (Bool) -> Void) {
    
        var request = URLRequest(url: Endpoints.logout.url)

        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
            
            // Clear login information
            UdacityClient.Auth.account = nil
            UdacityClient.Auth.session = nil
            
            // And data model
            DataModel.publicUserData = nil
            DataModel.studentInformationList = []
            
            DispatchQueue.main.async {
                completion(true)
            }
        }
        
        task.resume()
        
    }
    
    class func getPublicUserData(userId: String, completion: @escaping (Bool, ErrorType?) -> Void) {
        
        let request = URLRequest(url: Endpoints.getPublicUserData(userId).url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, ErrorType.NetworkError)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let newData = data.subdata(in: 5..<data.count)
                let responseObject = try decoder.decode(PublicUserDataResponse.self, from: newData)
                
                DataModel.publicUserData = responseObject as PublicUserDataResponse
                
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, ErrorType.DecodeError)
                }
            }
        }
        
        task.resume()
    }
    
}
