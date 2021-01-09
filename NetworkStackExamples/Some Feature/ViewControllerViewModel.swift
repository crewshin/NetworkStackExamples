//
//  ViewControllerViewModel.swift
//  NetworkStackExamples
//
//  Created by Gene Crucean on 1/9/21.
//

import Foundation

protocol ViewControllerViewModelDelegate: class {
    func peopleFetched()
    func peopleFetchErrored(error: SWAPIError)
}

class ViewControllerViewModel {
    
    var people = [Person]()
    weak var delegate: ViewControllerViewModelDelegate?
    let communicator: ViewControllerCommunicatorProtocol
    
    // Mmmm... dependency injection. Look in tests for example.
    init(communicator: ViewControllerCommunicatorProtocol = ViewControllerCommunicator()) {
        self.communicator = communicator
    }
    
    func convertCentimetersToInches(centimeters: Double) -> Double {
        // 1in = 2.54cm
        return centimeters / 2.54
    }
    
    func convertInchesToFeet(inches: Double) -> Double {
        // 1ft = 12in
        return inches / 12
    }
    
    func formatHeight(height: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: height)) ?? "ERROR"
    }
    
    func fetchPeople() {
        communicator.fetchPeople { [weak self] (res) in
            switch res {
            case .failure(let error):
                self?.delegate?.peopleFetchErrored(error: error)
            case .success(let response):
                self?.people = response.value.results
                self?.delegate?.peopleFetched()
            }
        }
    }
}
