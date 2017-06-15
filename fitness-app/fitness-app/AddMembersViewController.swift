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
    
    
    var leagueName: String!
    var members = Array<Member>()
    var databaseRef: DatabaseReference!
    let league = League()
    
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
                        member.myUserID = key as! String
                        member.myEmail = memberDictionary["email"] as! String
                        if key as! String != Auth.auth().currentUser?.uid {
                        self.members.append(member)
                        }
                    }
                }
                self.addMemberTable.reloadData()
  
            }
            
        }
        
        leagueLabel.text = leagueName
        league.myName = leagueName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = members[indexPath.item].myName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        league.myMembers.append(members[indexPath.item])
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            //how to handle a deselect
    }
    
    @IBAction func createLeague(_ sender: Any) {
        
        let myself = Member()
        myself.myUserID = Auth.auth().currentUser?.uid
        myself.myName = UserDefaults.standard.string(forKey: "name")
        myself.myEmail = UserDefaults.standard.string(forKey: "email")

        
        league.myMembers.append(myself)
        
        let leagueUrl = URL(string: "https://fitness-app-45481.firebaseio.com/Leagues.json")
        let userUrl = URL(string: "https://fitness-app-45481.firebaseio.com/Users.json")

        
        Alamofire.request(leagueUrl!, method: .post, parameters: league.toJSON(), encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
                
            case .success:
                print("Created League")
                
                for user in self.league.myMembers {
                    var member: Member!
                    member = user
                    
                    Alamofire.request(userUrl!, method: .put, parameters: member.toJSON(), encoding: JSONEncoding.default) {
                        
                    }
                    
                }
                
                self.dismiss(animated: true, completion: nil)
                
            case .failure: break
                // Failure... handle error
            }
        }
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
