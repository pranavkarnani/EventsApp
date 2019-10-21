//
//  SponsorViewController.swift
//  App-A-Thon
//
//  Created by Aritro Paul on 14/03/18.
//  Copyright © 2018 Pranav Karnani. All rights reserved.
//

import UIKit

class SponsorViewController: UIViewController {

    var sponsorNames = ["Brandstik","Cover It Up","JetBrains","Marposs","Souled Store",".tech","Wolfram Language","Venson Electronics","Zeplin"]
    var sponsorLogos = [#imageLiteral(resourceName: "Brandstik"),#imageLiteral(resourceName: "Coveritup"),#imageLiteral(resourceName: "Jetbrains"),#imageLiteral(resourceName: "Marposs"),#imageLiteral(resourceName: "souledstore"),#imageLiteral(resourceName: "tech"),#imageLiteral(resourceName: "Wolfram"),#imageLiteral(resourceName: "venson"),#imageLiteral(resourceName: "zeplin")]

    
    @IBAction func backBttn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goBack", sender: Any?.self)
        
        
    }
    @IBOutlet weak var sponsorsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sponsorsTable.dataSource = self
        sponsorsTable.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension SponsorViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as! SponsorTableViewCell
        cell.sponsorName.text! = sponsorNames[indexPath.row].uppercased()
        cell.sponsorImage.image = sponsorLogos[indexPath.row]
        cell.CellView.layer.cornerRadius = 10
        cell.CellView.layer.masksToBounds = true
        cell.CellView.layer.borderColor = UIColor(red: 60/255, green: 139/255, blue: 254/255, alpha: 1).cgColor
        cell.CellView.layer.borderWidth = 1.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sponsorNames.count
    }
     
}

