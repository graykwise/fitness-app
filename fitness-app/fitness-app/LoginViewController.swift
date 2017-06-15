//
//  LoginViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/12/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var errorPopup: UILabel!
    
    var databaseRef: DatabaseReference!

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        email.text = ""
        password.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        errorPopup.isHidden = true
        if Auth.auth().currentUser != nil {
                // User is signed in.
            Alamofire.request("https://fitness-app-45481.firebaseio.com/Users.json").responseJSON { response in
                if let JSON = response.result.value {
                    
                    let response = JSON as! NSDictionary
                    
                    //key is Leagues
                    //value is one league
                    //the one league needs to point to
                    for (key, value) in response {
                        
                        if let memberDictionary = value as? [String: AnyObject] {
                            if memberDictionary["userID"] as? String == Auth.auth().currentUser?.uid {
                                if memberDictionary["myLeague"] as? String != "" {
                                    self.performSegue(withIdentifier: "showLeague", sender: nil)
                                    UserDefaults.standard.set(memberDictionary["myLeague"], forKey: "leagueNameDefault") 
                                }
                                else{
                                    self.performSegue(withIdentifier: "pickLeague", sender: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
        // No user is signed in.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference(fromURL: "https://fitness-app-45481.firebaseio.com/")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginPressed(_ sender: UIButton) {

        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil {
                self.errorPopup.isHidden = true
                self.performSegue(withIdentifier: "showLeague", sender: nil)
                
            }
            else{
                self.errorPopup.isHidden = false

            }
            
            //They are logged in
            //
        }
    }
}

