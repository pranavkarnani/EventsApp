//
//  HomeViewController.swift
//  App-A-Thon
//
//
//
//

import UIKit

var selected = ""
var oldmarks = 0
class HomeViewController: UIViewController {
    
    @IBAction func unwindToMenufromQuiz(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBAction func wifiBttnTapped(_ sender: Any) {
        if regNo != "Guest" {
            selected = "wifi"
            self.performSegue(withIdentifier: "showMenu", sender: Any?.self)
        }
        else {
            self.showAlert(title: "Not Authorised", message: "Please personalise your application by heading over to settings on the top right corner")
        }
    }
    @IBAction func teamBttnTapped(_ sender: Any) {
        selected = "team"
        self.performSegue(withIdentifier: "showMenu", sender: Any?.self)
    }
    @IBAction func quizBttnTapped(_ sender: Any) {
        if regNo != "Guest" {
            selected = "quiz"
            self.performSegue(withIdentifier: "TOQUIZ", sender: Any?.self)
        }
        else {
            self.showAlert(title: "Not Authorised", message: "Please personalise your application by heading over to settings on the top right corner")
        }
    }
    @IBAction func foodBttnTapped(_ sender: Any) {
        if regNo != "Guest" {
        selected = "food"
        self.performSegue(withIdentifier: "showMenu", sender: Any?.self)
        }
        else {
            self.showAlert(title: "Not Authorised", message: "Please personalise your application by heading over to settings on the top right corner")
        }
    }
    
    @IBOutlet weak var teamBttn: UIButton!
    @IBOutlet weak var quizBttn: UIButton!
    @IBOutlet weak var wifiBttn: UIButton!
    @IBOutlet weak var foodBttn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getstudattempt()
        checkstat()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        welcomeLabel.text = regNo
        generateGradients()
    }
    
    func generateGradients()
    {
        foodBttn.setGradientBackground(colorOne: UIColor.orange, colorTwo: UIColor.yellow)
        wifiBttn.setGradientBackground(colorOne: Colors.wifiBlue, colorTwo: Colors.wifiGreen)
        quizBttn.setGradientBackground(colorOne: Colors.quizred, colorTwo: Colors.quizpink)
        teamBttn.setGradientBackground(colorOne: Colors.teamBlue, colorTwo: Colors.teamlightBlue)
    }
    
    override func viewDidLayoutSubviews() {
        
        foodBttn.layer.cornerRadius = 20
        quizBttn.layer.cornerRadius = 20
        teamBttn.layer.cornerRadius = 20
        wifiBttn.layer.cornerRadius = 20
        foodBttn.clipsToBounds = true
        wifiBttn.clipsToBounds = true
        teamBttn.clipsToBounds = true
        quizBttn.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title : String, message : String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let bttn = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(bttn)
        present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    
    func setGradientBackground(colorOne : UIColor, colorTwo : UIColor)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        
        gradientLayer.locations = [0.0,1.0]
        
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
