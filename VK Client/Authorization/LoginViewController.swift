//
//  LoginViewController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 29.07.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.isEnabled = false
        
        loginTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func pressedSignInButton(_ sender: UIButton) {
        
    }
    
    // Метод возврата на экран авторизации:
    @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let checkResult = isUserDataValid()
        
        if !checkResult {
            showLoginError()
        }
        
        return checkResult
    }
    
    // MARK: - Help Function
    
    func isUserDataValid() -> Bool {
        
        let login = loginTextField.text
        let password = passwordTextField.text
        
        if login == "Gagarin" && password == "1961" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        
        let alert = UIAlertController(title: "Error",
                                      message: """
                                               Your Login: Gagarin
                                               Your Password: 1961
                                               """,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok",
                                   style: .cancel)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
