//
//  RunInfoViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/14/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit

class RunInfoViewController: UIViewController {

    var myRun: Run!
    
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var runDistance: UILabel!
    @IBOutlet weak var runPace: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let counter = myRun.time
        let minutes = Int(counter) / 60
        let seconds = Int(counter) % 60
        if(seconds < 10){
            runTime.text = "\(minutes):0\(seconds)"
        }
        else{
            runTime.text = "\(minutes):\(seconds)"
        }
        
        runDistance.text = "\(myRun.getDistInMiles())"
        
        let paceMin = Int(myRun.pace) / 60
        let paceSec = Int(myRun.pace) % 60
        if(paceSec < 10){
            runPace.text = "\(paceMin):0\(paceSec)/mi"
        }
        else{
            runPace.text = "\(paceMin):\(paceSec)/mi"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
