//
//  StepStat.swift
//  SampleBit
//
//  Created by Ryan LaSante on 9/14/16.
//  Copyright © 2016 Fitbit. All rights reserved.
//

import UIKit

struct StepStat {

	let day: DateComponents
	let steps: UInt
	
	init?(withJSON json: String) {
		guard let jsonData = json.data(using: .utf8) else {
			return nil
		}
		self.init(withJSON: jsonData)
	}
	
	init?(withJSON jsonData: Data) {
		guard let data = (try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)) as? [String: Any] else {
			return nil
		}
		self.init(withDictionary: data)
	}
	
	init?(withDictionary data: [String: Any]) {
		guard let dateTime = data["dateTime"] as? String,
			let dateComponents = dateTime.dateComponents() else {
				return nil
		}
		
		guard let stepCount = (data["value"] as? NSNumber)?.uintValue ?? UInt((data["value"] as? String) ?? "") else {
			return nil
		}
		
		day = dateComponents
		steps = stepCount
	}

	static func fetchTodaysStepStat(callback: @escaping (StepStat?, Error?)->Void) -> URLSessionDataTask? {
		let datePath = "/today/1d.json"
		return fetchSteps(for: datePath) { (stepStats, error) in
			callback(stepStats?.first, error)
		}
	}

	static func fetchSteps(for dateRange: NSDateInterval, callback: @escaping ([StepStat]?, Error?)->Void) -> URLSessionDataTask? {
		let startDate = dateRange.startDate.dateString()
		let endDate = dateRange.endDate.dateString()
		let datePath = "/\(startDate)/\(endDate).json"
		return fetchSteps(for: datePath, callback: callback)
	}

	static func fetchSteps(for datePath: String, callback: @escaping ([StepStat]?, Error?)->Void) -> URLSessionDataTask? {
		guard let session = FitbitAPI.sharedInstance.session,
			let stepURL = URL(string: "https://api.fitbit.com/1/user/-/activities/steps/date\(datePath)") else {
				return nil
		}
		let dataTask = session.dataTask(with: stepURL) { (data, response, error) in
			guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
				DispatchQueue.main.async {
					callback(nil, error)
				}
				return
			}

			guard let data = data,
				let dictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: AnyObject] else {
					DispatchQueue.main.async {
						callback(nil, error)
					}
					return
			}
			print(dictionary)
			guard let steps = dictionary["activities-steps"] as? [[String: AnyObject]] else { return }
			let stats = steps.flatMap({ StepStat(withDictionary: $0) })
			DispatchQueue.main.async {
				callback(stats, nil)
			}
		}
		dataTask.resume()
		return dataTask
	}
}
