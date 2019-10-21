//
//  MenuViewController.swift
//  App-A-Thon
//
//
//  
//

import UIKit
import FirebaseDatabase


class MenuViewController: UIViewController {
    
    var ref : DatabaseReference!
    
    @IBOutlet weak var notselect: UILabel!
    @IBOutlet weak var select: UILabel!
    @IBOutlet weak var collections: UICollectionView!
    @IBAction func connectionIssues(_ sender: Any) {
        showAlert(title: "Recorded", message: "Your response has been recorded")
        foodBttn.backgroundColor = .clear
        foodBttn.setTitleColor(UIColor.black, for: UIControlState.normal)
        quizBttn.backgroundColor = .clear
        quizBttn.setTitleColor(UIColor.black, for: UIControlState.normal)
        teamBttn.backgroundColor = .clear
        teamBttn.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    @IBOutlet weak var connectionIssue: UIButton! 
    @IBAction func backButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timelineView: UIView!
    @IBOutlet weak var timelineTableView: UITableView!
    @IBOutlet weak var wifiView: UIView!
    @IBOutlet weak var refreshmentView: UIView!
    @IBOutlet weak var wifiImage: UIImageView!
    @IBOutlet weak var wifipass: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var actionAtTimeLabel: UILabel!
    @IBOutlet weak var wifiuser: UILabel!
    @IBAction func wifiBttnTapped(_ sender: Any) {
        selected = "wifi"
        timer.invalidate()
        if regNo != "Guest" {
            view.bringSubview(toFront: wifiView)
            updateViews()
        }
        else {
            self.showAlert(title: "Not Authorised", message: "Please personalise your application by heading over to settings on the top right corner")
        }
    }
    
    var timer = Timer()
    @IBAction func teamBttnTapped(_ sender: Any) {
        selected = "team"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getTime), userInfo: nil, repeats: true)
        view.bringSubview(toFront: timelineView)
        updateViews()
    }
    @IBAction func quizBttnTapped(_ sender: Any) {
        selected = "quiz"
        timer.invalidate()
        if regNo != "Guest" {
            self.performSegue(withIdentifier: "quiz", sender: Any?.self)
        }
        else {
            self.showAlert(title: "Not Authorised", message: "Please personalise your application by heading over to settings on the top right corner")
        }
    }
    @IBAction func foodBttnTapped(_ sender: Any) {
        selected = "food"
        timer.invalidate()
        if regNo != "Guest" {
            view.bringSubview(toFront: refreshmentView)
            updateViews()
        }
        else {
            self.showAlert(title: "Not Authorised", message: "Please personalise your application by heading over to settings on the top right corner")
        }
    }
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var teamBttn: UIButton!
    @IBOutlet weak var quizBttn: UIButton!
    @IBOutlet weak var wifiBttn: UIButton!
    @IBOutlet weak var foodBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let today = calendar.component(.day, from: date)
        if today == 31 {
            Time = Time1
            actionAtTime = actionAtTime1
        }
        
        syncMainEvent()
        if regNo != "Guest" {
             realtime()
        }
        rowPos = getIndexPathForScroll()
        wifipass.text! = "Password : \(wifiPassword)"
        wifiuser.text! = "Username : \(wifiUsername)"
        updateViews()
        getstudattempt()
        checkstat()
        
    }
    
    func realtime() {
        
        ref = Database.database().reference().child(regNo)
        ref.observe(.value, with: { (snapshot) in
            print(snapshot)
            let dictionary = snapshot.value as! [String:AnyObject]
            
            refreshmentStatus = dictionary["refreshmentStatus"] as! Bool
            wifiUsername = dictionary["wifiUsername"] as! String
            wifiPassword = dictionary["wifiPassword"] as! String
            goodiesStatus = dictionary["goodiesStatus"] as! Bool
            
            print("!!!")
            
            DataHandler.shared.deleteCachedData(completion: { (stat) in
                if stat {
                    DataHandler.shared.cacheUserData(completion: { (stat1) in
                        self.collections.reloadData()
                        self.wifipass.text! = "Password : \(wifiPassword)"
                        self.wifiuser.text! = "Username : \(wifiUsername)"
                    })
                }
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        foodBttn.layer.cornerRadius = 5
        wifiBttn.layer.cornerRadius = 5
        teamBttn.layer.cornerRadius = 5
        quizBttn.layer.cornerRadius = 5
        
        connectionIssue.layer.cornerRadius = 15
    }
    
    
    
    var indexTimed:Int = 0
    var CurTimeInt:Int = 0
    
    @objc func getTime() ->String{
        
        let Time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm"
        print(formatter.string(from: Time))
        return formatter.string(from: Time)
    }
    
    func updateViews() {
        
        foodBttn.backgroundColor = UIColor.clear
        teamBttn.backgroundColor = UIColor.clear
        quizBttn.backgroundColor = UIColor.clear
        wifiBttn.backgroundColor = UIColor.clear
        
        foodBttn.titleLabel?.textColor = UIColor.black
        wifiBttn.titleLabel?.textColor = UIColor.black
        teamBttn.titleLabel?.textColor = UIColor.black
        quizBttn.titleLabel?.textColor = UIColor.black
        
        if selected == "food" {
            view.bringSubview(toFront: refreshmentView)
            foodBttn.backgroundColor = Colors.teamBlue
            foodBttn.setTitleColor(UIColor.white, for: UIControlState.normal)
            
        }
        else if selected == "wifi" {
            view.bringSubview(toFront: wifiView)
            wifiBttn.backgroundColor = Colors.teamBlue
            wifiBttn.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
        
        else if selected == "team" {
            syncMainEvent()
            rowPos = getIndexPathForScroll()
            view.bringSubview(toFront: timelineView)
            teamBttn.backgroundColor = Colors.teamBlue
            teamBttn.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
        else {
            quizBttn.backgroundColor = Colors.teamBlue
            quizBttn.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
        
        view.bringSubview(toFront: backButton)
        
        let CurTime = getTime()
        CurTimeInt = Int(CurTime)!
        
        
        syncMainEvent()
        rowPos = getIndexPathForScroll()
        let indexPath = IndexPath(row: rowPos , section: 0)
        timelineTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
        
    }
    var rowPos = 0
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}

var Time = ["1000","1130","1200","1330","1600","2000","2230","2300"]
var Time1 = ["0530","0700","1000","1200","1400"]
var actionAtTime = ["Registrations Commence","Track Reveal","Let's Hack!!","Take a Break","Snacks?","Biometric for girls","Meals","Technical Inspection 1"]

var actionAtTime1 = ["Meals","Technical Inspection - Results", "Technical Inspection - 2","Technical Inspection 2 Results", "Pitching Begins"]

extension MenuViewController : UITableViewDataSource, UITableViewDelegate {
    
    func getIndexPathForScroll()->Int{
        var rowPos:Int = 0
        for row in Time{
            let rowAsInt = Int(row)!
            if(CurTimeInt <= rowAsInt){
                rowPos = Time.index(of: String(row))!
                break
            }
            else{
                rowPos = 2
            }
        }
        return rowPos
    }
    
    func syncMainEvent() {
        var rowPos:Int = 0
        for row in Time{
            let rowAsInt = Int(row)!
            if(CurTimeInt < rowAsInt){
                rowPos = Time.index(of: String(row))!
                rowPos = rowPos - 1
                if (rowPos == -1){
                    rowPos = 0
                }
                timeLabel.text = Time[rowPos]
                actionAtTimeLabel.text = actionAtTime[rowPos].uppercased()
                break
            }
            else{
                rowPos = 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as! TimelineTableViewCell
        cell.timeLabel.text = Time[indexPath.row]
        cell.actionAtTimeLabel.text = actionAtTime[indexPath.row].uppercased()
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.masksToBounds = true
        cell.cellView.layer.borderColor = UIColor(red: 60/255, green: 139/255, blue: 254/255, alpha: 1).cgColor
        cell.cellView.layer.borderWidth = 1.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Time.count
    }
}

extension MenuViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! MenuCollectionViewCell
        var type = ""
        var expiry : Bool = false

        
        if indexPath.item == 0 {
            item.couponType.text = "FOOD"
            type = "food"
            expiry = refreshmentStatus
            select.text = "●"
            notselect.text = "○"
            
        }
        else {
            item.couponType.text = "GOODIES"
            type = "goodies"
            expiry = goodiesStatus
            notselect.text = "●"
            select.text = "○"

        }
        
        item.qrCode.image = generateQRCode(from: regNo+"_"+type)
        
        if expiry {
            item.status.text = "REDEEMED"
            item.status.textColor = Colors.wifiBlue
        }
        else {
            item.status.text = "NOT REDEEMED"
            item.status.textColor = UIColor.red
        }
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        return UIEdgeInsetsMake(15, 15, 15, 15)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-10, height: collectionView.frame.height-40)
    }
    
    func showAlert(title : String, message : String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let bttn = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(bttn)
        present(alert, animated: true, completion: nil)
    }
    

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = collections.indexPathsForVisibleItems.first {
            print(indexPath.row)
            
            if indexPath.row == 1 {
                notselect.text = "●"
                select.text = "○"
            }
            else {
                select.text = "●"
                notselect.text = "○"
            }
        }
    }
}

