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
        
        var stringValue: String {
            
            switch self {
                case .getStudentLocations:
                    return Endpoints.base + "?limit=100&order=-updatedAt"
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
}
