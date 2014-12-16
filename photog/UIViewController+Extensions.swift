//
//  UIViewController+Extensions.swift
//  photog
//
//  Created by Ryan Valle on 12/13/14.
//  Copyright (c) 2014 RyanValle.me. All rights reserved.
//

import Foundation

extension UIViewController {
    func showAlert(message: String) {
        self.showAlert("Error", message: message)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}