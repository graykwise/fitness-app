//
//  RunInfoViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/14/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class RunInfoViewController: UIViewController {

    var myRun: Run!
    
    var databaseRef: DatabaseReference!
   
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var runDistance: UILabel!
    @IBOutlet weak var runPace: UILabel!
    var roundedMiles = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference(fromURL: "https://fitness-app-45481.firebaseio.com/")

        // Do any additional setup after loading the view.
        let counter = myRun.time
        let minutes = Int(counter) / 60
        let seconds = Int(counter) % 60
        if(seconds < 10){
            runTime.text = "\(minutes):0\(seconds)"
        }
        else{
            runTime.text = "\(minutes):\(seconds)"
        }
        
        let miles = myRun.distance * 0.0006213712
        roundedMiles = Double( round(100 * miles) / 100)
        runDistance.text = "\(roundedMiles)"
        
        let paceMin = Int(myRun.pace) / 60
        let paceSec = Int(myRun.pace) % 60
        if(paceSec < 10){
            runPace.text = "\(paceMin):0\(paceSec)/mi"
        }
        else{
            runPace.text = "\(paceMin):\(paceSec)/mi"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToLeague(_ sender: UIBarButtonItem) {
        //save run to database under user and update total miles
        //get user miles
        var useURL = URL(string: "https://fitness-app-45481.firebaseio.com/Users.json")
        
        var myID = Auth.auth().currentUser?.uid
        
        Alamofire.request(useURL!).responseJSON {
            response in
            
            if let JSON = response.result.value {
                
                let response = JSON as! NSDictionary
                
                for (key, value) in response {
                    
                    if let userDictionary = value as? [String : AnyObject] {
                        
                        if myID == userDictionary["userID"] as? String{
                            var myself = Member()
                            var newURL = URL(string: "https://fitness-app-45481.firebaseio.com/Users")

                            newURL?.appendPathComponent("\(myID!).json")
                            
                            
                            if let myMiles = userDictionary["miles"] {
                                var milesInDouble: Double!
                                milesInDouble = myMiles.doubleValue
                                milesInDouble = milesInDouble + self.roundedMiles
                                //post
                                myself.myUserID = myID
                                myself.miles = milesInDouble
                                
                                Alamofire.request(newURL!, method: .patch, parameters: myself.toJSON(), encoding: JSONEncoding.default).responseJSON {
                                    response in
                                    
                                    
                                }
                                
                                var leagueView = (UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "League") as! LeagueViewController)
                                
                                self.show(leagueView, sender: nil)

                                
                                
                            }
                        }
                    }
                }
            }
            
        }
        //add
        
        
        //post back up (patch?)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
