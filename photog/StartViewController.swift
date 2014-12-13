//
//  StartViewController.swift
//  photog
//
//  Created by Ryan Valle on 12/5/14.
//  Copyright (c) 2014 RyanValle.me. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    // functinon that exists in the superclass viewcontroller and override its function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide navigation bar
        // be sure startViewController.view.backgroundColor = UIColor.yellowColor() is commented out under AppDelegate.swift for navigationController? to work
        self.navigationController?.navigationBarHidden = true
        
    }

    // if application gets memory warning, this method will be called to release/dispose of memory being used
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        var viewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapSignUp(sender: AnyObject) {
        var viewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
