//
//  String+Extensions.swift
//  photog
//
//  Created by Ryan Valle on 12/13/14.
//  Copyright (c) 2014 RyanValle.me. All rights reserved.
//

import Foundation

extension String {
    func isEmailAddress() -> Bool {
        var predicate = self.predicateForEmail()
        return predicate.evaluateWithObject(self)
    }
    
    func predicateForEmail() -> NSPredicate {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression)
    }
}