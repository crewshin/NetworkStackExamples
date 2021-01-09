//
//  Networking.swift
//  NetworkStackExamples
//
//  Created by Gene Crucean on 1/9/21.
//

import Foundation

struct Networking {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func decodableTask<T: Decodable>(request: URLRequest, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<Response<T>, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data,
                  error == nil,
                  let response = response,
                  let objectOutput = try? JSONDecoder().decode(T.self, from: data)
            else {
                // Log global network related errors here if needed.
                return
            }

            completion(.success(Response(value: objectOutput, response: response)))
            
        }.resume()
    }
}
