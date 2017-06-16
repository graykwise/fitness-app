//
//  Run.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/14/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import Foundation
import Gloss
import Alamofire
import Firebase

class Run: Glossy, Decodable, Encodable {
    
    
    
    var time: Double
    var distance: Double
    var pace: Double
    
    init() {
        time = 0
        distance = 0
        pace = 0
    }
    
    func saveRun(time: Double, distance: Double) {
        self.time = time
        self.distance = distance
        
        let miles = distance * 0.0006213712
        let roundedMiles = Double( round(100 * miles) / 100)
        
        pace = time / roundedMiles
    }
    
    required init?(json: JSON) {
        self.time = ("time" <~~ json)!
        self.distance = ("distance" <~~ json)!
        self.pace = ("pace" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "time" ~~> self.time,
            "distance" ~~> self.distance,
            "pace" ~~> self.pace
            ])
    }

}
