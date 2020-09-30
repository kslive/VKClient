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
    
    let networkManager = NetworkManager.shared
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        let token = params["access_token"]
        let userID = params["user_id"]
        
        Session.shared.userId = Int(userID ?? "")
        
        guard token != nil else { return }
        
        Session.shared.token = token!
        let loadViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoadView") as UIViewController
        self.present(loadViewController, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
}


