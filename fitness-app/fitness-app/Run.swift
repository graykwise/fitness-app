//
//  Run.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/14/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import Foundation

class Run {
    
    var time: Double
    var distance: Double
    var pace: Double
    var distInMiles: Double
    
    init() {
        time = 0
        distance = 0
        pace = 0
        distInMiles = 0
    }
    
    func saveRun(time: Double, distance: Double) {
        self.time = time
        self.distance = distance
        
        let miles = distance * 0.0006213712
        let roundedMiles = Double( round(100 * miles) / 100)
        distInMiles = roundedMiles

        pace = time / roundedMiles
    }
    
    func getDistInMiles() -> Double{
        return distInMiles
    }

}
