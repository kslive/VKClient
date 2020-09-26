//
//  LoginViewController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 29.07.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressedSignInButton(_ sender: UIButton) {
        
    }
    
    // Метод возврата на экран авторизации:
    @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
    }
}
