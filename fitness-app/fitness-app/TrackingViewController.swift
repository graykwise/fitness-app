//
//  TrackingViewController.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/13/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import UIKit
import MapKit

class TrackingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    var locationManager: CLLocationManager!
    var currentUserLocation: CLLocation!
    var timer: Timer!
    var counter: Int!
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var traveledDistance: Double = 0
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.showsUserLocation = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        timer = Timer()
        counter = 0
        distanceLabel.text = String(traveledDistance)
        timerLabel.text = String(counter)
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
        map.setRegion(coordinateRegion, animated: true)
        
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            traveledDistance += lastLocation.distance(from: location)
            updateDistance(distance: traveledDistance)
            //print("Traveled Distance:",  traveledDistance)
        }
        lastLocation = locations.last
    }
    
    @IBAction func startRun(_ sender: UIButton) {
        if(sender.currentTitle == "Start") {
            //Change to pause button
            sender.setTitle("Pause", for: UIControlState.normal)
            
            //Start timer
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.keepTime), userInfo: nil, repeats: true)
            
            //Start tracking location
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
                locationManager.startUpdatingHeading()
                locationManager.startMonitoringSignificantLocationChanges()
                locationManager.distanceFilter = 10
                map.userTrackingMode = .followWithHeading
            }
        }
            
        else if (sender.currentTitle == "Pause") {
            //Stop the run
            sender.setTitle("Start", for: UIControlState.normal)
            timer.invalidate()
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingHeading()

        }

    }
    
    func updateDistance(distance: Double) {
        let miles = distance * 0.0006213712
        let roundedMiles = Double( round(100 * miles) / 100)
        distanceLabel.text = "\(roundedMiles)"
    }
    
    func keepTime() {
        counter = counter + 1
        let minutes = counter/60
        let seconds = counter%60
        if(seconds < 10){
            timerLabel.text = "\(minutes):0\(seconds)"
        }
        else{
        timerLabel.text = "\(minutes):\(seconds)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToChallenge(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveRun" {
            let savedRun = Run()
            
            //this saves the run with the time in seconds and distance in meters
            savedRun.saveRun(time: Double(counter), distance: traveledDistance)
            
            let navController = segue.destination as! UINavigationController
            let runInfoController = navController.topViewController as! RunInfoViewController
            runInfoController.myRun = savedRun
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
