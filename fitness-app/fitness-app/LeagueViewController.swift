//
//  LeagueViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/12/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Alamofire

class LeagueViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet weak var leagueName: UINavigationItem!
    
    let myLeague = League()

    @IBOutlet weak var challenge: UILabel!
    @IBOutlet weak var memberTable: UITableView!
    @IBOutlet weak var wager: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        memberTable.delegate = self
        memberTable.dataSource = self
        //Load this specific League from the database of Leagues
        Alamofire.request("https://fitness-app-45481.firebaseio.com/Leagues.json").responseJSON { response in
            if let JSON = response.result.value {
                
                let response = JSON as! NSDictionary
                
                
                //key is Leagues
                //value is one league
                //the one league needs to point to
                for (key, value) in response {
                    
                    if let leagueDictionary = value as? [String : AnyObject] {
                        
                        self.myLeague.myName = leagueDictionary["Name"] as! String
                        self.myLeague.myBet.betString = leagueDictionary["Bet"] as! String
                        self.myLeague.myChallenge.challengeString = leagueDictionary["Challenge"] as! String
                        
                        self.challenge.text = self.myLeague.myChallenge.challengeString
                        self.wager.text = self.myLeague.myBet.betString
                        
                        self.leagueName.title = self.myLeague.myName
                        self.myLeague.myChallenge.challengeString = leagueDictionary["Challenge"] as! String
                        
                        if let memberDictionary = leagueDictionary["Members"] as? [String : Int] {
                            
                            for (key, value) in memberDictionary {
                                let member = Member()
                                member.myName = ""
                                member.myUserID = value
                                self.myLeague.myMembers.append(member)
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
                        member.myUserID = userDictionary["ID"] as! Int
                        
                        for oneUser in self.myLeague.myMembers {
                            
                            if member.myUserID == oneUser.myUserID {
                                oneUser.myName = member.myName
                                self.memberTable.reloadData()

                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLeague.myMembers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = myLeague.myMembers[indexPath.item].myName
            return cell
        }
    
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
