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
        
        case test
        
        var stringValue: String {
            
            switch self {
                case .test:
                    return Endpoints.base
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func loadStudentLocations(completion: @escaping (Bool, Error?) -> Void) {
        
        var request = URLRequest(url: Endpoints.test.url)
        
        request.addValue(ParseSecrets.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseSecrets.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(StudentLocationsResult.self, from: data)

                StudentInformationModel.studentInformationList = responseObject.results
                
                DispatchQueue.main.async {
                    completion(true, nil)
                }

            } catch {
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
            
        }
        
        task.resume()
        
    }
}
