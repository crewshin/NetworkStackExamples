//
//  SWAPI.swift
//  NetworkStackExamples
//
//  Created by Gene Crucean on 1/9/21.
//

import Foundation

// StarWars API
enum SWAPI {
    static let networking = Networking()
    static let base = URL(string: "http://swapi.dev/api")!
}

enum SWAPIError: Error {
    case peopleFailed(message: String)
}

extension SWAPI {
    
    static func people(completion: @escaping (Result<Networking.Response<PersonResponse>, SWAPIError>) -> Void) {
                        
        let request = URLRequest(url: base.appendingPathComponent("people"))
        
        networking.decodableTask(request: request) { (result: Result<Networking.Response<PersonResponse>, Error>) in
            
            switch result {
            case .failure(let error):
                // Log `people` related network errors herem if needed.
                completion(.failure(.peopleFailed(message: error.localizedDescription)))
            case .success(let res):
                completion(.success(res))
            }
        }
    }
}
