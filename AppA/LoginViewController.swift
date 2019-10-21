//
//  LoginViewController.swift
//  App-A-Thon
//
//  
//
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBttn: UIButton!
    
    @IBAction func loginTapped(_ sender: Any) {
        regNo = "Guest"
        self.performSegue(withIdentifier: "toLoginScreen", sender: Any?.self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        loginBttn.layer.cornerRadius = 20
    }
}
