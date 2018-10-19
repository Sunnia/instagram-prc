//
//  ViewController.swift
//  InstagramApiPrc
//
//  Created by MichaelShih on 2018/10/19.
//  Copyright © 2018 Sunnia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.testSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func touchinsideGoooooalBtn() {
        print("start session....")
        self.testSession()
        print("session sendd finished....")
    }
    func testSession() {
        let sessionConfig: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: sessionConfig)
        //let request = URLRequest(url: NSURL(string: "https://api.instagram.com/oauth/authorize/?client_id=ac6f04ecfd654a809269c214173b7e72&response_type=token&redirect_uri=https://www.plurk.com/Allmoe")! as URL)
        let request = URLRequest(url: NSURL(string: "https://api.instagram.com/oauth/authorize/")! as URL)
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            }else{
                let str = String(data: data!, encoding: String.Encoding.utf8)
                print(data?.description)
                //print("\(str)")
                /*
                guard let jsondata = (try? JSONSerialization.jsonObject(with: data!, options: [] ) )as? [String : Any]
                    else {print("error:", error ?? "nil"); return }
                
                let json = jsondata
                let url = json["url"]
                let explanation = json["explanation"]
                //print("\(#function) \(#line) \(data)")
                print("\(#function) \(#line) \(url)")
                print("\(#function) \(#line) \(explanation)")
                */
                
            }
        })
        
        dataTask.resume()
        /*
        
        let jsondata = JSONSerialization.jsonObject(with: data, options: [] ) as? [String : Any]
        
        let json = jsondata
        let url = json["url"]
        let explanation = json["explanation"]
        print("\(#function) \(#line) \(data)")
        print("\(#function) \(#line) \(url)")
        print("\(#function) \(#line) \(explanation)")
 */
    }


}

