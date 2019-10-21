//
//  SettingsViewController.swift
//  App-A-Thon
//
//  Created by Pranav Karnani on 10/03/18.
//  Copyright © 2018 Pranav Karnani. All rights reserved.
//

import UIKit
import FirebaseDatabase
class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref : DatabaseReference!
    @IBAction func unwindToSettingsfromSponsor(segue: UIStoryboardSegue) {}

    @IBAction func backBttn(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoMenu", sender: Any?.self)
    }
    
    var list : [String] = ["Call Support","Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableViewCell
        cell.thumbnail.image = UIImage(named : list[indexPath.row])
        cell.thumbnailTitle.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if list[indexPath.row] == "Log Out" {
            DataHandler.shared.deleteCachedData(completion: { (stats) in
                if stats {
                    self.ref = Database.database().reference().child(regNo)
                    if regNo != "Guest" {
                        self.ref.updateChildValues(["barcodeUsed":false])
                    }
                    
                    
                    refreshmentStatus = false
                    goodiesStatus = false
                    regNo = "Guest"
                    wifiUsername = "N/A"
                    wifiPassword = "N/A"
                    isLoggedIn = false
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let board = storyboard.instantiateInitialViewController() as! LandingViewController
                    UIApplication.shared.keyWindow?.rootViewController = board
                }
            })
        }

        else if list[indexPath.row] == "Call Support" {
            if let url = URL(string: "tel://\(9007784562)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
            
        else {
            self.performSegue(withIdentifier: list[indexPath.row], sender: Any?.self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
