//
//  LoginViewController+KeyboardSettings.swift
//  VK Client
//
//  Created by Eugene Kiselev on 21.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

extension LoginViewController {
    
    @objc func textFieldDidChange(textField: UITextField) {
        if loginTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            signInButton.isEnabled = false
        } else {
            signInButton.isEnabled = true
        }
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
        self.scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }

    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
}
