//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Frank Mortensen on 07/02/2019.
//  Copyright © 2019 Frank Mortensen. All rights reserved.
//

import Foundation

class ParseClient {
    
    struct ParseSecrets {
        static let applicationId: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let apiKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    enum Endpoints {
        static let base = "https://parse.udacity.com/parse/classes/StudentLocation"
        
        case getStudentLocations
        case putStudentLocation(String)
        case postStudentLocation
        
        var stringValue: String {
            
            switch self {
            case .getStudentLocations:
                return Endpoints.base + "?limit=100&order=-updatedAt"
                
            case .postStudentLocation:
                return Endpoints.base
                
            case .putStudentLocation(let objectId):
                return Endpoints.base + "/\(objectId)"
            
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func loadStudentLocations(completion: @escaping (Bool, ErrorType?) -> Void) {
        print("loadStudentLocations START")
        var request = URLRequest(url: Endpoints.getStudentLocations.url)
        
        request.addValue(ParseSecrets.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseSecrets.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
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
                let responseObject = try decoder.decode(GetStudentLocationsResponse.self, from: data)

                DataModel.studentInformationList = responseObject.results
                
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
    
    class func putStudentLocation(location: StudentInformation, completion: @escaping (Bool, ErrorType?) -> Void) {
        let body = location
        
        var request = URLRequest(url: Endpoints.putStudentLocation(location.objectId!).url)
        
        request.httpMethod = "PUT"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ParseSecrets.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseSecrets.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, ErrorType.NetworkError)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(PutLocationResponse.self, from: data)
                
                DataModel.studentInformation!.updatedAt = responseObject.updatedAt
                
                DispatchQueue.main.async {
                    completion(true, nil)
                }
                
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(false, ErrorType.DecodeError)
                }
            }
        }
        
        task.resume()
        
    }
    
    class func postStudentLocation(location: StudentInformation, completion: @escaping (Bool, ErrorType?) -> Void) {
        
        
        let body = location
        
        var request = URLRequest(url: Endpoints.postStudentLocation.url)
        
        request.httpMethod = location.objectId != nil ? "PUT" : "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ParseSecrets.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseSecrets.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, ErrorType.NetworkError)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(PostLocationResponse.self, from: data)
                
                DataModel.studentInformation!.createdAt = responseObject.createdAt
                DataModel.studentInformation!.objectId = responseObject.objectId
                
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
