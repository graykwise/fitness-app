//
//  ChallengeViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/12/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Alamofire

class ChallengeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load this specific League from the database of Leagues
        Alamofire.request("https://fitness-app-45481.firebaseio.com/Leagues.json").responseJSON { response in
            if let JSON = response.result.value {
                
                let response = JSON as! NSDictionary
                
                for (key, value) in response {
                    
                    //One dictionary to hold challenge information
                    if let leagueDictionary = value as? [String : Dictionary<String, AnyObject>] {
                        
                        //follow this pattern:
                        //activity?.name = actDictionary["name"] as! String
                    }
                }
                //Reload data to see League Info
                self.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
