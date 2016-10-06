//
//  FitbitAPI.swift
//  SampleBit
//
//  Created by Ryan LaSante on 9/14/16.
//  Copyright © 2016 Fitbit. All rights reserved.
//

import UIKit

class FitbitAPI {
	
	static let sharedInstance: FitbitAPI = FitbitAPI()
	
	static let baseAPIURL = URL(string:"https://api.fitbit.com/1")
	
	func authorize(with token: String) {
		let sessionConfiguration = URLSessionConfiguration.default
		var headers = sessionConfiguration.httpAdditionalHeaders ?? [:]
		headers["Authorization"] = "Bearer \(token)"
		sessionConfiguration.httpAdditionalHeaders = headers
		session = URLSession(configuration: sessionConfiguration)
	}
	
	var session: URLSession?
}
