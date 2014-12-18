//
//  AuthViewController.swift
//  photog
//
//  Created by Ryan Valle on 12/10/14.
//  Copyright (c) 2014 RyanValle.me. All rights reserved.
//

import UIKit

enum AuthMode {
    case SignIn
    case SignUp
}

class AuthViewController: UIViewController, UITextFieldDelegate {

    var authmode: AuthMode = AuthMode.SignUp
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        var emailImageView = UIImageView(frame: CGRectMake(0, 0, 50, self.emailTextField!.frame.size.height))
        emailImageView.image = UIImage(named: "EmailIcon")
        emailImageView.contentMode = .Center
        
        self.emailTextField!.leftView = emailImageView
        self.emailTextField!.leftViewMode = .Always
        
        var passwordImageView = UIImageView(frame: CGRectMake(0, 0, 50, self.passwordTextField!.frame.size.height))
        passwordImageView.image = UIImage(named: "PasswordIcon")
        passwordImageView.contentMode = .Center
        
        self.passwordTextField!.leftView = passwordImageView
        self.passwordTextField!.leftViewMode = .Always
        
        if authmode == .SignIn {
            self.navigationItem.title = "Sign In"
        } else {
            self.navigationItem.title = "Sign Up"
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.emailTextField?.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.emailTextField) {
            self.emailTextField?.resignFirstResponder()
            self.passwordTextField?.becomeFirstResponder()
        } else if (textField == self.passwordTextField) {
            self.passwordTextField?.resignFirstResponder()
            self.authenticate()
        }
        return true
    }
    
    func authenticate() {
        var email = self.emailTextField?.text
        var password = self.passwordTextField?.text
        
        if (email?.isEmpty == true || password?.isEmpty == true || email?.isEmailAddress() == false) {
            self.showAlert("Check E-Mail and Password")
            return
        }
        
        if authmode == .SignIn {
            self.signIn(email!, password: password!)
        } else {
            self.signUp(email!, password: password!);
        }
    }
    
    func signIn(email: String, password: String) {
        PFUser.logInWithUsernameInBackground(email, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            
            if (user != nil) {
                self.loadTabViewController()
            } else {
                self.showAlert("Failed to sign in. Check e-mail address and password!")
            }
        }
    }
    
    func signUp(email: String, password: String) {
        var user = PFUser()
        user.username = email
        user.email = email
        user.password = password
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            
            if error == nil {
                NetworkManager.sharedInstance.follow(user, completionHandler: {
                    (error) -> Void in
                    if error == nil {
                        self.loadTabViewController()
                    } else {
                        println("unable for user to follow themselves")
                    }
                })
            } else {
                self.showAlert("Failed to sign up.")
            }
        }
    }
    
    func loadTabViewController() {
        var tabViewController = TabBarController()
        self.navigationController?.pushViewController(tabViewController, animated: true)
    }
    
}
