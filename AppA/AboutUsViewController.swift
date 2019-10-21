//
//  AboutUsViewController.swift
//  App-A-Thon
//
//  Created by Pranav Karnani on 14/03/18.
//  Copyright © 2018 Pranav Karnani. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func backBttnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "settings", sender: Any?.self)
    }
    let names : [String] = ["Mohit Anand","Tanvi Vijay","Rushabh Shah"]
    let images : [String] = ["mohit","tanvi","random"]
    let titles : [String] = ["iOS Developer","Designer","Firebase Configuration Manager"]
    
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
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AboutUsTableViewCell
        cell.sponsorImage.image = UIImage(named : images[indexPath.row])
        cell.sponsorImage.layer.cornerRadius = cell.sponsorImage.frame.height/2
        cell.sponsorName.text = names[indexPath.row]
        cell.Cellview.layer.cornerRadius = 10
        cell.descript.text = titles[indexPath.row]
        cell.Cellview.layer.masksToBounds = true
        cell.Cellview.layer.borderColor = UIColor(red: 60/255, green: 139/255, blue: 254/255, alpha: 1).cgColor
        cell.Cellview.layer.borderWidth = 1.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
