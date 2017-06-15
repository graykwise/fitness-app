//
//  AddMembersViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/14/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class AddMembersViewController: UIViewController,UITableViewDelegate,  UITableViewDataSource {

    @IBOutlet weak var addMemberTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func createLeague(_ sender: Any) {
        
    }
    
    var leagueName: String!
    var members = Array<Member>()
    var databaseRef: DatabaseReference!
    
    @IBOutlet weak var leagueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference(fromURL: "https://fitness-app-45481.firebaseio.com/")
        
        addMemberTable.delegate = self
        addMemberTable.dataSource = self
        
        Alamofire.request("https://fitness-app-45481.firebaseio.com/Users.json").responseJSON { response in
            if let JSON = response.result.value {
                
                let response = JSON as! NSDictionary
                
                //key is Leagues
                //value is one league
                //the one league needs to point to
                for (key, value) in response {
                    var member = Member()

                    if let memberDictionary = value as? [String: AnyObject] {
                        member.myName = memberDictionary["name"] as! String
                        if key as! String != Auth.auth().currentUser?.uid {
                        self.members.append(member)
                        }
                    }
                }
                self.addMemberTable.reloadData()
  
            }
            
        }
        
        leagueLabel.text = leagueName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = members[indexPath.item].myName
        return cell
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
