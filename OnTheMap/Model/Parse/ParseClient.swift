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
        case postStudentLocation
        
        var stringValue: String {
            
            switch self {
                case .getStudentLocations:
                    return Endpoints.base + "?limit=100&order=-updatedAt"
                
                case .postStudentLocation:
                    return Endpoints.base
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func loadStudentLocations(completion: @escaping (Bool, Error?) -> Void) {
        print("loadStudentLocations START")
        var request = URLRequest(url: Endpoints.getStudentLocations.url)
        
        request.addValue(ParseSecrets.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseSecrets.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                
                print("loadStudentLocations NO DATA")
                
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(StudentLocationsResult.self, from: data)

                DataModel.studentInformationList = responseObject.results
                
                print("loadStudentLocations SUCCESS")
                
                DispatchQueue.main.async {
                    completion(true, nil)
                }

            } catch {
                print("loadStudentLocations ERROR")
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
            
        }
        
        task.resume()
        
    }
    
    class func postStudentLocation(location: StudentLocation, completion: @escaping (Bool, Error?) -> Void) {
        
        
        let body = location
        
        var request = URLRequest(url: Endpoints.postStudentLocation.url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ParseSecrets.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseSecrets.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(PostLocationResult.self, from: data)
                
                DataModel.studentInformation!.createdAt = responseObject.createdAt
                DataModel.studentInformation!.objectId = responseObject.objectId
                
                DispatchQueue.main.async {
                    completion(true, nil)
                }
                
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
        }
        
        task.resume()
        
        
    }
}
