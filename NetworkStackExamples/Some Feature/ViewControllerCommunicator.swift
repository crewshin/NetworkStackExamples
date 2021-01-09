//
//  ViewControllerCommunicator.swift
//  NetworkStackExamples
//
//  Created by Gene Crucean on 1/9/21.
//

import Foundation

protocol ViewControllerCommunicatorProtocol {
    func fetchPeople(completion: @escaping (Result<Networking.Response<PersonResponse>, SWAPIError>) -> Void)
}

struct ViewControllerCommunicator: ViewControllerCommunicatorProtocol {
    func fetchPeople(completion: @escaping (Result<Networking.Response<PersonResponse>, SWAPIError>) -> Void) {
        SWAPI.people(completion: { (response) in
            completion(response)
        })
    }
}
