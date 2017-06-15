//
//  LeagueViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/12/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class LeagueViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet weak var leagueName: UINavigationItem!
    
    var databaseRef: DatabaseReference!
    var cellStyle = "member"
    var myLeague = League()

    @IBOutlet weak var challenge: UILabel!
    @IBOutlet weak var memberTable: UITableView!
    @IBOutlet weak var wager: UILabel!

    var memberNames = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challenge.isHidden = true
        wager.isHidden = true
        databaseRef = Database.database().reference(fromURL: "https://fitness-app-45481.firebaseio.com/")

        memberTable.delegate = self
        memberTable.dataSource = self
        //Load this specific League from the database of Leagues
        Alamofire.request("https://fitness-app-45481.firebaseio.com/Leagues.json").responseJSON { response in
            if let JSON = response.result.value {
                
                let response = JSON as! NSDictionary

                for (key, value) in response {
                    
                    if let leagueDictionary = value as? [String : AnyObject] {
                        
                        if leagueDictionary["name"] as? String == UserDefaults.standard.string(forKey: "leagueNameDefault") {
                        self.myLeague.myName = leagueDictionary["name"] as! String
                            
                        //make bet dictionary
                            if let betDictionary = leagueDictionary["bet"] as? [String : AnyObject] {
                        self.myLeague.myBet.betString = betDictionary["betString"] as! String
                            }
                        //make challenge dictionary
                            if let challengeDictionary = leagueDictionary["challenge"] as? [String : AnyObject] {
                                self.myLeague.myChallenge.challengeString = challengeDictionary["challengeString"] as! String
                            }
                        
                        self.challenge.text = self.myLeague.myChallenge.challengeString
                        self.wager.text = self.myLeague.myBet.betString
                        self.leagueName.title = self.myLeague.myName
                        self.challenge.isHidden = false
                        self.wager.isHidden = false
                            
                        //member dictionary
                         if let membersArray = leagueDictionary["members"] as? [String] {
                            for oneMember in membersArray {
                                self.myLeague.myMembers.append(oneMember)
                            }
                        }
                        
                            
                        }
                    }
                }
                self.matchUsers(league: self.myLeague)
                //Reload data to see League Info
                self.memberTable.reloadData()
            }
        }
        
    }
    
    func matchUsers(league: League) {
        
        Alamofire.request("https://fitness-app-45481.firebaseio.com/Users.json").responseJSON { response in
            if let JSON = response.result.value {
                
                let response = JSON as! NSDictionary
                
                for (key, value) in response {
                    
                    if let userDictionary = value as? [String : AnyObject] {
                        let member = Member()
                        member.myName = userDictionary["name"] as! String
                        member.myUserID = userDictionary["userID"] as! String
                        
                        for oneUser in self.myLeague.myMembers {
                            
                            if member.myUserID == oneUser {
                                self.memberNames.append(member.myName)
                                if Auth.auth().currentUser?.uid == member.myUserID {
                                    self.cellStyle = "currentUser"
                                }
                                self.memberTable.reloadData()
                                self.cellStyle = "member"
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberNames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->   UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellStyle)
        cell.textLabel?.text = memberNames[indexPath.item]
        return cell
        }
    
    @IBAction func logout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        }
        catch {
            
        }
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
