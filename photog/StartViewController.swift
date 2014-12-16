//
//  StartViewController.swift
//  photog
//
//  Created by Ryan Valle on 12/5/14.
//  Copyright (c) 2014 RyanValle.me. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    // if application gets memory warning, this method will be called to release/dispose of memory being used
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        var viewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        viewController.authmode = .SignIn
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapSignUp(sender: AnyObject) {
        var viewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        viewController.authmode = .SignUp
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
