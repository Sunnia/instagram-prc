//
//  InstagramAuthViewController.swift
//  InstagramApiPrc
//
//  Created by MichaelShih on 2018/10/19.
//  Copyright © 2018 Sunnia. All rights reserved.
//

import UIKit
import WebKit

struct API{
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_CLIENT_ID = ""
    static let INSTAGRAM_CLIENTSERCRET = ""
    static let INSTAGRAM_REDIRECT_URI = "https://www.plurk.com/Allmoe"
    static let INSTAGRAM_ACCESS_TOKEN = ""
    static let INSTAGRAM_SCOPE = "public_content"
    /* add whatever scope you need https://www.instagram.com/developer/authorization/ */
}
protocol InstaAuthDelegate {
    func didGetAccessToken(access_token: String)
}

class InstagramAuthViewController: UIViewController {
    
    @IBOutlet weak var navagateBar: UINavigationBar!
    @IBOutlet weak var webView: UIWebView!
    
    var delegate:InstaAuthDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.testSession()
    }
    
    @IBAction func touchinsideNavXButtom() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func testSession() {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@", arguments: [API.INSTAGRAM_AUTHURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_REDIRECT_URI,API.INSTAGRAM_SCOPE])
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        webView.loadRequest(urlRequest)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(API.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: String(requestURLString[range.upperBound...]))
            return false;
        }
        return true
    }
    func handleAuth(authToken: String) {
        print("Instagram authentication token ==", authToken)
        self.delegate?.didGetAccessToken(access_token: authToken)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension InstagramAuthViewController: UIWebViewDelegate{
    func webView(_ webView: UIWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        return checkRequestForCallbackURL(request: request)
    }
}
extension InstagramAuthViewController: WKNavigationDelegate{
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        print("michael check")
        checkRequestForCallbackURL(request: navigationAction.request)
        
    }
}
