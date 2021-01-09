//
//  NetworkStackExamplesTests.swift
//  NetworkStackExamplesTests
//
//  Created by Gene Crucean on 1/8/21.
//

import XCTest
@testable import NetworkStackExamples

class NetworkStackExamplesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHeightConversions() {
        
        // Yuk. This is less than ideal. In this simple case it works fine, but falls on it's face in more complex scenarios.
        let vc = ViewController()
        let responseHeight = "175" // Data from response is a string.
        let centimeters = Double(responseHeight)!
        let inches = vc.convertCentimetersToInches(centimeters: centimeters)
        let feet = vc.convertInchesToFeet(inches: inches)
        let outputString = "Height: \(vc.formatHeight(height: feet))ft"
        
        XCTAssertEqual(outputString, "Height: 5.7ft")
    }
}
