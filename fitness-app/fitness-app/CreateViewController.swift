//
//  CreateViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/14/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    
    @IBOutlet weak var leagueName: UITextField!
    
    @IBOutlet weak var wagerLabel: UITextField!
    @IBOutlet weak var challengeLabel: UITextField!
    @IBAction func addMembers(_ sender: UIButton) {
        if leagueName.text == "" || challengeLabel.text == "" || wagerLabel.text == "" {
            
        }
        else
        {
            self.performSegue(withIdentifier: "toAddMembers", sender: nil)
        }
    }
    
    @IBAction func backToChoose(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toAddMembers") {
            let navCont = segue.destination as! UINavigationController
            let newCont = navCont.topViewController as! AddMembersViewController
            
            newCont.leagueName = leagueName.text
            newCont.leagueChallenge = challengeLabel.text
            newCont.leagueBet = wagerLabel.text
            
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
