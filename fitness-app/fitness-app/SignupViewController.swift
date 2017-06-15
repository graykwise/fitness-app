//
//  SignupViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/14/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import Firebase


class SignupViewController: UIViewController {

    var databaseRef: DatabaseReference!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference(fromURL: "https://fitness-app-45481.firebaseio.com/")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil {
                self.databaseRef.child("Users").child((user?.uid)!)
                    .setValue(["email": self.email.text!, "name": self.name.text!, "league": ""])
            }

            //They are logged in
            
        
            self.performSegue(withIdentifier: "signUp", sender: nil)
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
