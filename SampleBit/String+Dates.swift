//
//  String+Dates.swift
//  SampleBit
//
//  Created by Ryan LaSante on 9/14/16.
//  Copyright © 2016 Fitbit. All rights reserved.
//

import UIKit

extension String {
	func date(withFormat format: String = "yyyy-MM-dd") -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.date(from: self)
	}
	
	func dateComponents(withFormat format: String = "yyyy-MM-dd", components: Set<Calendar.Component> = [.day, .month, .year]) -> DateComponents? {
		return self.date(withFormat: format)?.dateComponents(components: components)
	}
}

extension Date {
	func dateComponents(components: Set<Calendar.Component> = [.day, .month, .year]) -> DateComponents {
		let calendar = Calendar.current
		return calendar.dateComponents(components, from: self)
	}

	func dateString(withFormat format: String = "yyyy-MM-dd") -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: self)
	}
}
