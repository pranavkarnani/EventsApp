//
//  ViewController.swift
//  App-A-Thon
//
//  Created by Pranav Karnani on 01/02/18.
//  Copyright © 2018 Pranav Karnani. All rights reserved.
//

import UIKit
import CoreData
import Alamofire


var issueCount = 0
var regNo : String = "Guest"
var isLoggedIn : Bool = false
var wifiUsername : String = "N/A"
var wifiPassword : String = "N/A"
var gotResponse : Bool = false
var refreshmentStatus : Bool = false
var barcodeStatus : Bool = false
var goodiesStatus : Bool = false

class LandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DataHandler.shared.retrieveData() { retrieveSuccessful in
            if retrieveSuccessful
            {
                print(regNo)
                self.decide()
            }
        }
    }
    
    
    func decide()
    {
        
        let downloadurl = URL(string: "https://www.google.com")!
        Alamofire.request(downloadurl).responseJSON
            { response in
                print(response.response?.statusCode ?? 0)
                if(response.response?.statusCode == 200)
                {
                    if isLoggedIn {
                        self.performSegue(withIdentifier: "loggedIn", sender: Any?.self)
                    }
                    else {
                        wifiUsername = "N/A"
                        wifiPassword = "N/A"
                        self.performSegue(withIdentifier: "notLoggedIn", sender: Any?.self)
                    }
                }
                else if(response.response?.statusCode != 200)
                {
                    self.createalert(title: "Connectivity Error", message: "Please check your internet connection and relaunch the app.")
                }
                
        }
    }
    
    
    func createalert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (action) in
            if let url = URL(string: "App-Prefs:root=//") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, completionHandler: .none)
                } else {
                }
            }
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

