//
//  LoginViewController.swift
//  SampleBit
//
//  Created by Stephen Barnes on 9/14/16.
//  Copyright © 2016 Fitbit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AuthenticationProtocol {
	@IBOutlet weak var logoutButton: UIBarButtonItem!
	var authenticationController: AuthenticationController?

	override func viewDidLoad() {
		super.viewDidLoad()
		authenticationController = AuthenticationController(delegate: self)
	}

	// MARK: Actions
	@IBAction func login(_ sender: AnyObject) {
		authenticationController?.login(fromParentViewController: self)
	}

	@IBAction func logout(_ sender: AnyObject) {
		AuthenticationController.logout()
	}

	// MARK: AuthenticationProtocol

	func authorizationDidFinish(_ success: Bool) {
		print("Hello World with \(success)!")
		guard let authToken = authenticationController?.authenticationToken else {
			return
		}
		FitbitAPI.sharedInstance.authorize(with: authToken)
		performSegue(withIdentifier: "Steps", sender: self)
	}
}

