//
//  StepViewController.swift
//  SampleBit
//
//  Created by Ryan LaSante on 9/14/16.
//  Copyright © 2016 Fitbit. All rights reserved.
//

import UIKit

let SECONDS_PER_MINUTE = 60.0
let MINUTES_PER_HOUR = 60.0
let HOURS_PER_DAY = 24.0
let SECONDS_PER_HOUR = SECONDS_PER_MINUTE * MINUTES_PER_HOUR
let SECONDS_PER_DAY = HOURS_PER_DAY * SECONDS_PER_HOUR

class StepViewController: UIViewController {

	@IBOutlet var stepLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

//		let _ = StepStat.fetchSteps(for: NSDateInterval(start: Date(timeIntervalSinceNow: -30 * SECONDS_PER_DAY), end: Date())) { [weak self] stepStats, error in
//			guard let stepStats = stepStats else {
//				return
//			}
//			let stepText: [String] = stepStats.map({ "\($0.steps)" })
//			self?.stepLabel.text = stepText.joined(separator: ", ")
//		}

		let _ = StepStat.fetchTodaysStepStat() { [weak self] stepStat, error in
			let steps = stepStat?.steps ?? 0
			self?.stepLabel.text = "\(steps)"
		}
    }
}
