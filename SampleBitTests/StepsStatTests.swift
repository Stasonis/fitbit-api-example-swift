//
//  StepsStatTests.swift
//  SampleBit
//
//  Created by Ryan LaSante on 9/14/16.
//  Copyright © 2016 Fitbit. All rights reserved.
//

import XCTest

@testable import SampleBit

class StepsStatTests: XCTestCase {
	
	struct Defaults {
		static let year = 2011
		static let month = 10
		static let day = 27
		static let stepCount = 555
	}
	
	let jsonString: String = "{\"dateTime\":\"\(Defaults.year)-\(Defaults.month)-\(Defaults.day)\",\"value\":\(Defaults.stepCount)}"
	
    func testDictionaryInitialization() {
		let dictionary: [String: Any] = ["dateTime": "\(Defaults.year)-\(Defaults.month)-\(Defaults.day)", "value": Defaults.stepCount]
		guard let stat = StepsStat(withDictionary: dictionary) else {
			XCTFail("Failed to initialize the StepsStat struct")
			return
		}
		
		XCTAssertEqual(stat.steps, UInt(Defaults.stepCount), "Steps were incorrectly parsed out of the dictionary")
		XCTAssertTrue(stat.day.year == Defaults.year, "Year wasn't properly parsed out of the dictionary dateTime")
		XCTAssertTrue(stat.day.month == Defaults.month, "Month wasn't properly parsed out of the dictionary dateTime")
		XCTAssertTrue(stat.day.day == Defaults.day, "Day wasn't properly parsed out of the dictionary dateTime")
    }
	
	func testDataInitialization() {
		guard let jsonData = jsonString.data(using: .utf8) else {
			XCTFail("Failed generating data from the json String")
			return
		}
		guard let stat = StepsStat(withJSON: jsonData) else {
			XCTFail("Failed to initialize the StepsStat struct")
			return
		}
		
		XCTAssertEqual(stat.steps, UInt(Defaults.stepCount), "Steps were incorrectly parsed out of the dictionary")
		XCTAssertTrue(stat.day.year == Defaults.year, "Year wasn't properly parsed out of the dictionary dateTime")
		XCTAssertTrue(stat.day.month == Defaults.month, "Month wasn't properly parsed out of the dictionary dateTime")
		XCTAssertTrue(stat.day.day == Defaults.day, "Day wasn't properly parsed out of the dictionary dateTime")
	}
	
	func testJSONStringInitialization() {
		guard let stat = StepsStat(withJSON: jsonString) else {
			XCTFail("Failed to initialize the StepsStat struct")
			return
		}
		
		XCTAssertEqual(stat.steps, UInt(Defaults.stepCount), "Steps were incorrectly parsed out of the dictionary")
		XCTAssertTrue(stat.day.year == Defaults.year, "Year wasn't properly parsed out of the dictionary dateTime")
		XCTAssertTrue(stat.day.month == Defaults.month, "Month wasn't properly parsed out of the dictionary dateTime")
		XCTAssertTrue(stat.day.day == Defaults.day, "Day wasn't properly parsed out of the dictionary dateTime")
	}
}
