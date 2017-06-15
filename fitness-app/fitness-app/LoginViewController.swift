//
//  LoginViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/12/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var errorPopup: UILabel!
    
    var databaseRef: DatabaseReference!

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        errorPopup.isHidden = true
//        if Auth.auth().currentUser != nil {
//                // User is signed in.
//            performSegue(withIdentifier: "pickLeague", sender: nil)
//        } else {
//                // No user is signed in.
//        }
    
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
                self.performSegue(withIdentifier: "pickLeague", sender: nil)
            }
            else{
                self.errorPopup.isHidden = false

            }
            
            //They are logged in
            //
        }
    }
}

