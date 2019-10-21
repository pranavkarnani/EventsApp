import UIKit
import FirebaseDatabase
var selectedopt:Int!
var attempted:Int!
var studref:DatabaseReference!
var quiz = 0

func checkstat() {
    var ref:DatabaseReference!
    ref = Database.database().reference().child("Quiz")
    ref.observe(.value,with: { snapshot in
        if snapshot.exists() {
            let value = snapshot.value as? NSMutableDictionary
            quiz = value?.value(forKey: "round") as! Int
        }
    })
}

func getstudattempt() {
    studref = Database.database().reference().child(regNo)
    studref.observe(.value,with: { snapshot in
        if snapshot.exists() {
            let value = snapshot.value as? NSMutableDictionary
            attempted = value?.value(forKey: "attempted") as! Int
            oldmarks = value?.value(forKey: "marks") as! Int
        }
    })
}

class quizViewController: UIViewController {
    
    @IBOutlet weak var refresh: UIButton!
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var answerview: UIView!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var left: UILabel!
    @IBOutlet weak var down: UIImageView!
    @IBOutlet weak var maintitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var finalscore: UILabel!
    @IBOutlet weak var sectime: UILabel!
    
    @IBAction func refreshpressed(_ sender: Any) {
        self.viewDidLoad()
    }
    
    @IBAction func backpressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindfromQuiz", sender: self)
    }
    
    @IBOutlet weak var timeback: UIImageView!
    
    var timeover:Bool!
    var i = 0
    var SwiftTimer = Timer()
    var tmpButton:UIButton!
    var seconds = 0
    var minutes = 0
    var timee = 120
    var marks = 0
    var count = 0
    var newsec = 12
    var lastpressed:Int!
    var ref:DatabaseReference!
    
    func createalert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func nextpressed(_ sender: Any) {
        if(lastpressed != nil) {
            newTimer.invalidate()
            if(count == 9) {
                submit.setTitle("Finish", for: .normal)
            }
            if(tempoptions[count-1][lastpressed-1] == tempans.value(forKey: String(count)) as! String) {
                marks = marks + 1
            }
            
            tmpButton = self.view.viewWithTag(lastpressed) as? UIButton
            tmpButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lastpressed = nil
            
            if count != 10 {
                count = count + 1
                setquestion()
                newsec = 12
                sectime.text = "00:12"
                sectime.textColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
                newTimer = Timer.scheduledTimer(timeInterval: 12, target: self, selector: #selector(changeQuestion), userInfo: nil, repeats: true)
            }
            else {
                SwiftTimer.invalidate()
                newTimer.invalidate()
                createalert(title: "Thank You!", message: "Thank you for attempting the quiz.")
                mainview.isHidden = true
                mainview.isUserInteractionEnabled = false
                sectime.isHidden = true
                timeback.isHidden = true
                down.image = #imageLiteral(resourceName: "done")
                down.isHidden = false
                back.isHidden = false
                back.isUserInteractionEnabled = true
                
                if(attempted == 2) {
                    down.image = #imageLiteral(resourceName: "congo")
                    finalscore.text = "You've scored \(marks+oldmarks) out of 20."
                    finalscore.isHidden = false
                }
                
                refresh.isHidden = false
                refresh.isUserInteractionEnabled = true
                studref.child("marks").setValue(marks+oldmarks)
                resettimer()
                submit.setTitle("Next", for: .normal)
            }
        }
        else {
            createalert(title: "Alert!", message: "Please select an option")
        }
    }
    
    
    @IBAction func option1pressed(_ sender: Any) {
        if lastpressed != nil {
            tmpButton = self.view.viewWithTag(lastpressed) as? UIButton
            tmpButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        option1.backgroundColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        lastpressed = option1.tag
    }
    
    @IBAction func option2pressed(_ sender: Any) {
        if lastpressed != nil {
            tmpButton = self.view.viewWithTag(lastpressed) as? UIButton
            tmpButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        option2.backgroundColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        lastpressed = option2.tag
    }
    
    @IBAction func option3pressed(_ sender: Any) {
        if lastpressed != nil{
            tmpButton = self.view.viewWithTag(lastpressed) as? UIButton
            tmpButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        option3.backgroundColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        lastpressed = option3.tag
    }
    
    @IBAction func option4pressed(_ sender: Any) {
        if lastpressed != nil{
            tmpButton = self.view.viewWithTag(lastpressed) as? UIButton
            tmpButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        option4.backgroundColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        lastpressed = option4.tag
    }
    
    var quest1:NSMutableDictionary = ["1":"Given : var stringValue:String = “Justin Gif”What is the result of stringValue = nil ?","2":"Which of the following is not a valid declaration in C?","3":"Which type of data file is analogous to an audio cassette tape?","4":"What's the output of the following?\nchar *mychar; // points to memory location 1000 short *mychart; // points to memory location 2000 long *mylong// points to memory location 3000 mychar++; ++myshort; mylong++; count<<mychar<<myshort<<mylong;","5":"Which one of the following is not a valid reserved keyword in C++?","6":"Value of a in a = (b = 5, b + 5); is","7":"Given an empty function of type void, what value is shown when executed at the shell?","8":"What is the output of print(math.factorial(4.5))?","9":"Is the following piece of code valid? (Python)\na={1,4,{6,9}}\nprint(a[2][0])","10":"a={'B':5,'A':9,'C':7}\nprint(sorted(a))"]
    
    var options1 = [["stringValue == nil","stringValue == “Justin Gif”","The compiler won't allow it","None of the above"],["short int x;","signed short x;","short x;","unsigned short x;"],["random access file","sequential access file","binary file","source code file"],["1001 2001 3001","1001 2002 3004","1001 2001 3002","1001 2002 3004"],["Explicit","Public","Implicit","Private"],["Junk value","Syntax error","5","10"],["int","bool","void","None"],["24","120","error","20!"],["Yes, 6 is printed","Error, elements of a set can’t be printed","Error, subsets aren’t allowed","Yes, {6,9} is printed"],["['A','B','C']","['B','C','A']","[5,7,9]","[9,5,7]"]]
    
    var ans1:NSMutableDictionary = ["1":"The compiler won't allow it","2":"unsigned short x;","3":"sequential access file","4":"1001 2002 3004","5":"Implicit","6":"10","7":"None","8":"error","9":"Error, subsets aren’t allowed","10":"['A','B','C']"]
    
    var quest2:NSMutableDictionary = ["1":"x = ['wx', 'ya']\nprint(list(map(list, x)))\nWhat is the output??","2":"flag = [[5, 2, 7],[2, 7, 8],[1, 4, 1]]\n[flag[i][1] for i in (0, 1, 2)]","3":"print('areuserious'.find('se') == 'se' in'areuserious')",
                                      "4":"A binary search tree whose left subtree and right subtree differ in hight by at most 1 unit is called ……","5":"What is not the component of data structure ?","6":"Which of the following data structure can’t store the non-homogeneous data elements?","7":"Apriory algorithm analysis does not include −","8":"Access time of a binary search tree may go worse in terms of time complexity upto","9":"if __name__ == '__main__':\nsomemethod()","10":"In python 3 what does // operator do ?"]
    
    var options2 = [["['w','x','y','a']","[['wx'], ['ya']]","[['w', 'x'], ['y', 'a']]","Error"],["[5, 2, 7]","[7, 8, 1]","[2, 7, 4]","[1, 4, 1]"],["True","False","Error","None of the mentioned"],["AVL tree","Red-black tree","Lemma tree","None of the above"],["Operations","Storage Structures","Algorithms","None of above"],["Arrays","Records","Pointers","Stacks"],["Time Complexity","Space Complexity","Program Complexity","None of the above!"],["Ο(n2)","Ο(n log n)","Ο(n)","Ο(1)"],["Create new module","Define generators","Run python module as main program","Create new objects"],["Float division","Integer division","returns remainder","same as a**b"]]
    
    var ans2:NSMutableDictionary = ["1":"[['w', 'x'], ['y', 'a']]","2":"[2, 7, 4]","3":"False","4":"AVL tree","5":"None of above","6":"Arrays","7":"Program Complexity","8":"Ο(n)","9":"Run python module as main program","10":"Integer division"]
    
    var tempquest:NSMutableDictionary!
    var tempoptions:[[String]]!
    var tempans:NSMutableDictionary!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        marks = 0
        resettimer()
        checkstat()
        submit.isUserInteractionEnabled = false
        submit.isHidden = true
        question.layer.cornerRadius = 10
        answerview.layer.cornerRadius = 10
        option1.layer.cornerRadius = 10
        option2.layer.cornerRadius = 10
        option3.layer.cornerRadius = 10
        option4.layer.cornerRadius = 10
        option1.layer.borderWidth = 1
        option2.layer.borderWidth = 1
        option3.layer.borderWidth = 1
        option4.layer.borderWidth = 1
        option1.layer.borderColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        option2.layer.borderColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        option3.layer.borderColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        option4.layer.borderColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        submit.setTitle("Next", for: .normal)
        
        finalscore.isHidden = true
        refresh.layer.cornerRadius = 15
        submit.layer.cornerRadius = 15
        mainview.isHidden = true
        mainview.isUserInteractionEnabled = false
        sectime.isHidden = true
        timeback.isHidden = true
        back.isHidden = false
        back.isUserInteractionEnabled = true
        
        checkattempt()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkattempt() {
        if(attempted == quiz && quiz != 0) {
            down.image = #imageLiteral(resourceName: "done")
            back.isHidden = false
            back.isUserInteractionEnabled = true
            if(quiz == 2) {
                down.image = #imageLiteral(resourceName: "congo")
                finalscore.text = "You've scored \(oldmarks) out of 20."
                finalscore.isHidden = false
                refresh.isUserInteractionEnabled = false
                refresh.isHidden = true
            }
        }
            
        else if(attempted != quiz) {
            print("okay")
            back.isHidden = true
            back.isUserInteractionEnabled = false
            startquiz()
        }
        else if(attempted == quiz && quiz == 0) {
            down.image = #imageLiteral(resourceName: "ohno")
            finalscore.text = ""
            finalscore.isHidden = true
        }
    }
    
    func runtimer() {
        SwiftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timer), userInfo: nil, repeats: true)
        newTimer = Timer.scheduledTimer(timeInterval: 13, target: self, selector: #selector(changeQuestion), userInfo: nil, repeats: true)
    }
    
    @objc func changeQuestion() {
        if(count == 9) {
            submit.setTitle("Finish", for: .normal)
        }
        
        if(lastpressed != nil) {
        
            if(tempoptions[count-1][lastpressed-1] == tempans.value(forKey: String(count)) as! String) {
                marks = marks + 1
            }
            tmpButton = self.view.viewWithTag(lastpressed) as? UIButton
            tmpButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lastpressed = nil
        }
        
        if count != 10 {
            count = count + 1
            newsec = 12
            sectime.text = "00:12"
            sectime.textColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
            setquestion()
        }
        else {
            SwiftTimer.invalidate()
            newTimer.invalidate()
            createalert(title: "Thank You!", message: "Thank you for attempting the quiz.")
            mainview.isHidden = true
            mainview.isUserInteractionEnabled = false
            sectime.isHidden = true
            timeback.isHidden = true
            down.image = #imageLiteral(resourceName: "done")
            down.isHidden = false
            back.isHidden = false
            back.isUserInteractionEnabled = true
            if(attempted == 2)
            {down.image = #imageLiteral(resourceName: "congo")
                finalscore.text = "You've scored \(marks+oldmarks) out of 20."
                finalscore.isHidden = false
                print("AT THE END OF 2 ROUNDS YOU HAVE SCORED \(marks+oldmarks) OUT OF 20.")
            }
            refresh.isHidden = false
            refresh.isUserInteractionEnabled = true
            studref.child("marks").setValue(marks+oldmarks)
            
            resettimer()
            submit.setTitle("Next", for: .normal)
        }
    }
    
    var newTimer = Timer()
    
    func startquiz() {
        if(quiz == 0) {
            back.isHidden = false
            back.isUserInteractionEnabled = true
        }
  
        else {
            if(quiz == 1) {
                tempquest = quest1
                tempoptions = options1
                tempans = ans1
            }
            else if(quiz == 2) {
                tempquest = quest2
                tempoptions = options2
                tempans = ans2
            }
            count = 1
            refresh.isHidden = true
            refresh.isUserInteractionEnabled = false
            sectime.isHidden = false
            timeback.isHidden = false
            submit.isHidden = false
            submit.isUserInteractionEnabled = true
            down.isHidden = true
            setquestion()
            runtimer()
            mainview.isHidden = false
            mainview.isUserInteractionEnabled = true
            studref.child("attempted").setValue(quiz)
        }
    }
    
    func setquestion() {
        maintitle.text = "Question \(count) of 10."
        question.text = tempquest.value(forKey: String(count)) as! String
        option1.setTitle(tempoptions[count-1][0], for: .normal)
        option2.setTitle(tempoptions[count-1][1], for: .normal)
        option3.setTitle(tempoptions[count-1][2], for: .normal)
        option4.setTitle(tempoptions[count-1][3], for: .normal)
    }
    
    func resettimer() {
        timee = 120
        seconds = 120
        minutes = 0
        newsec = 12
        sectime.textColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
        sectime.text = "00:12"
        time.text = "01:00"
        time.textColor = #colorLiteral(red: 0.2323561609, green: 0.6008039117, blue: 0.9467888474, alpha: 1)
    }
    
    @objc func timer() {
        switch UIApplication.shared.applicationState {
        case .active:
            break
        case .background:
            SwiftTimer.invalidate()
            newTimer.invalidate()
            mainview.isHidden = true
            mainview.isUserInteractionEnabled = false
            sectime.isHidden = true
            timeback.isHidden = true
            down.image = #imageLiteral(resourceName: "done")
            down.isHidden = false
            back.isHidden = false
            back.isUserInteractionEnabled = true
            
            refresh.isHidden = false
            refresh.isUserInteractionEnabled = true
            if(attempted == 2) {
                down.image = #imageLiteral(resourceName: "congo")
                finalscore.text = "You've scored \(marks+oldmarks) out of 20."
                finalscore.isHidden = false
            }
            
            createalert(title: "Wrong Move!", message: "Shouldn't have quit... You scored \(marks) marks.")
            studref.child("marks").setValue(marks+oldmarks)
            
        case .inactive:
            break
        }
        
        timee = timee - 1
        newsec = newsec - 1
        
        if(timee == 0) {
            
            SwiftTimer.invalidate()
            newTimer.invalidate()
            createalert(title: "Oh No!", message: "Looks like you ran out of time! You scored \(marks).")
            studref.child("marks").setValue(marks+oldmarks)
            mainview.isHidden = true
            mainview.isUserInteractionEnabled = false
            sectime.isHidden = true
            timeback.isHidden = true
            down.image = #imageLiteral(resourceName: "done")
            down.isHidden = false
            back.isHidden = false
            back.isUserInteractionEnabled = true
            if(attempted == 2) {
                down.image = #imageLiteral(resourceName: "congo")
                finalscore.text = "You've scored \(marks+oldmarks) out of 20."
                finalscore.isHidden = false
            }
            refresh.isHidden = false
            refresh.isUserInteractionEnabled = true

        seconds = seconds-1
        
        if(newsec < 10 )
        {
            sectime.textColor = UIColor.red
            sectime.text = "00:0\(newsec)"
        }
        if(newsec >= 10)
        {
            sectime.text = "00:\(newsec)"
        }
        
        if(seconds < 10 && minutes == 0)
        {
            time.textColor = UIColor.red
        }
        if(minutes < 10)
        {
            time.text = "0\(minutes):\(seconds)"
        }
        
        if(seconds < 10)
        {
            time.text = "\(minutes):0\(seconds)"
        }
        if (seconds < 10 && minutes < 10)
        {
            time.text = "0\(minutes):0\(seconds)"
        }
        if(minutes == 10 && seconds > 10)
        {
            time.text = "\(minutes):\(seconds)"
        }
        
        if (seconds == 0)
        {
            minutes = minutes - 1
            seconds = 60
        }
    }
    }
}
