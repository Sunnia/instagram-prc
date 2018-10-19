//
//  ViewController.swift
//  InstagramApiPrc
//
//  Created by MichaelShih on 2018/10/19.
//  Copyright © 2018 Sunnia. All rights reserved.
//

import UIKit


class InstaInfoParameter {
    var apUserDefaults :UserDefaults! = UserDefaults.standard
    static private var Instance: InstaInfoParameter?
    
    var access_token: String = ""
    
    private init() {
        access_token = defaultAccessToken()
    }
    
    
    func reset() {
        access_token = defaultAccessToken()
    }
    
    static func getInstance() -> InstaInfoParameter {
        if let settingValue = Instance {
            return settingValue
        }
        else {
            Instance = InstaInfoParameter()
            return Instance!
        }
    }
    
    private func defaultAccessToken()->String {
        if let access_t = apUserDefaults.object(forKey: "access_token") as? String {
            return access_t
        } else {
            return ""
        }
    }
    
    func save()  {
        apUserDefaults.set(self.access_token, forKey: "access_token")
    }
}

class ViewController: UIViewController {
    
    var instaInfo: InstaInfoParameter = InstaInfoParameter.getInstance()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.testSession()
        if self.instaInfo.access_token != "" {
            print("app start access_token is \(self.instaInfo.access_token)")
        } else {
            print("access_token unset")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //super.prepare(for: segue, sender: sender)
        if segue.identifier == "goAuthWebView" {
            let nextView = segue.destination as! InstagramAuthViewController
            nextView.delegate = self
        }
    }
    
    @IBAction func touchinsideGoooooalBtn() {
        
    }
    func showAuthView() {
        
    }
    
    

}

extension ViewController:InstaAuthDelegate{
    func didGetAccessToken(access_token: String) {
        self.instaInfo.access_token = access_token
        self.instaInfo.save()
        print("set token \(self.instaInfo.access_token)")
    }
    
    
}



