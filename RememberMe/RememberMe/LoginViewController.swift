//
//  LoginViewController.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/14/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var signUpButtonOutlet: UIView!
    @IBOutlet weak var whiteBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonViews()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

    }
    
    private func setupButtonViews() {
        
        // shadow
        loginButtonOutlet.layer.shadowColor = UIColor.red.cgColor
      
        loginButtonOutlet.layer.shadowOffset = CGSize(width: 1, height: 1)
        loginButtonOutlet.layer.shadowOpacity = 1
        loginButtonOutlet.layer.shadowRadius = 3
        // shape
        loginButtonOutlet.layer.cornerRadius = 25
        loginButtonOutlet.layer.masksToBounds = false
        
        // shadow
        signUpButtonOutlet.layer.shadowColor = UIColor.red.cgColor
        
        signUpButtonOutlet.layer.shadowOffset = CGSize(width: 1, height: 1)
        signUpButtonOutlet.layer.shadowOpacity = 1
        signUpButtonOutlet.layer.shadowRadius = 3
        // shape
        signUpButtonOutlet.layer.cornerRadius = 25
        signUpButtonOutlet.layer.masksToBounds = false
        whiteBackgroundView.layer.cornerRadius = 25
        
        
    }
    

    @IBAction func loginButtonAction(_ sender: Any) {
    }
    @IBAction func signUpButtonAction(_ sender: Any) {
    }
    
}
