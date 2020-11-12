//
//  AuthorizationWebViewController.swift
//  VK Client
//
//  Created by Eugene Kiselev on 26.09.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit
import WebKit

class AuthorizationWebViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    private let firebaseManager = FirebaseManager()
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRequest()
    }
    
    // MARK: Actions
    
    @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
        
        logOut()
    }
    
    // MARK: Help Functions
    
    private func logOut() {
        
        firebaseManager.logOut { [weak self] in
            
            self?.loadRequest()
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func loadRequest() {
        
        guard let request = networkManager.fetchRequestAuthorization() else { return }
        
        webView.load(request)
    }
}

extension AuthorizationWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        let tokens = params["access_token"]
        let userID = params["user_id"]
        
        Session.shared.userId = Int(userID ?? "")
        
        guard let token = tokens,
              let user = userID else { return }
        
        Session.shared.token = token
        firebaseManager.saveUser(userID: user)
        firebaseManager.configureAuthorization()
        
        let loadViewController = storyboard!.instantiateViewController(withIdentifier: "LoadView") as UIViewController
        present(loadViewController, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
}


