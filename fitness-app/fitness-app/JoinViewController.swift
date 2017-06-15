//
//  JoinViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/14/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Alamofire

class JoinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var leaguesTable: UITableView!
    
    var leagues = Array<League>()
    var selectedLeague = League()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leaguesTable.delegate = self
        leaguesTable.dataSource = self
        
        Alamofire.request("https://fitness-app-45481.firebaseio.com/Leagues.json").responseJSON { response in
            if let JSON = response.result.value {
                
                let response = JSON as! NSDictionary
                
                //key is Leagues
                //value is one league
                //the one league needs to point to
                for (key, value) in response {
                    
                    
                    let league = League()
                    
                    if let leagueDictionary = value as? [String: AnyObject] {
                        league.myName = leagueDictionary["name"] as! String
                        self.leagues.append(league)
                    }
                }
                self.leaguesTable.reloadData()
                
            }
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLeague = leagues[indexPath.item]

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = leagues[indexPath.item].myName
        return cell
    }
    
    
    @IBAction func backToChoose(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func joinLeague(_ sender: UIButton) {
        
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
