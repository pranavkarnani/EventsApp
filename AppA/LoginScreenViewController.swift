//
//  LoginScreenViewController.swift
//  AppA
//
//  
//
//

import UIKit
import FirebaseDatabase

class LoginScreenViewController: UIViewController {
    var ref : DatabaseReference!
    
    @IBAction func loginBttn(_ sender: Any) {
        
        if usernameField.text == "" || passwordField.text == "" {
            self.showAlert(title: "Error", message: "One of the fields has been left empty")
        }
            
        else {
            ref = Database.database().reference()
            regNo = usernameField.text!
            isLoggedIn = true
            loadFirebaseData()
            
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        loginBttnTapped.layer.cornerRadius = 20
    }
    @IBOutlet weak var loginBttnTapped: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.autocapitalizationType = .allCharacters
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let bttn = UIAlertAction(title: "Done", style: .default, handler: nil)
        alert.addAction(bttn)
        present(alert, animated: true, completion: nil)
    }
    
    func loadFirebaseData() {
        
        DispatchQueue.main.async {
            var ref = Database.database().reference()
            print(ref)
            print(regNo)
            ref.observeSingleEvent(of: .value, with: { (snap) in
                
                if snap.hasChild(regNo) {
                    ref = Database.database().reference().child(regNo)
                    
                    ref.observeSingleEvent(of: .value, with: { (snapshot) in
                        if let userDict = snapshot.value as? [String:Any] {
                            let password = userDict["myPassword"] as? String ?? "N/A"
                            print(password)
                            
                            if self.passwordField.text! == password {
                                
                                wifiPassword = userDict["wifiPassword"] as? String ?? "N/A"
                                wifiUsername = userDict["wifiUsername"] as? String ?? "N/A"
                                refreshmentStatus = userDict["refreshmentStatus"] as? Bool ?? false
                                barcodeStatus = userDict["barcodeUsed"] as? Bool ?? false
                                isLoggedIn = true
                                
                                DataHandler.shared.cacheUserData(completion: { (persisted) in
                                    if persisted && barcodeStatus == false  {
                                        ref.updateChildValues(["barcodeUsed":true])
                                        self.performSegue(withIdentifier: "loginSuccessful", sender: Any?.self)
                                    }
                                    else if barcodeStatus {
                                        self.showAlert(title: "Trouble Logging in", message: "You are already logged in to another device")
                                        return
                                    }
                                })
                            }
                            else {
                                self.showAlert(title: "Error", message: "Incorrect Credentials")
                            }
                        }
                    })
                    
                }
                else {
                    self.showAlert(title: "Error", message: "Not a valid user")
                }
            })
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
