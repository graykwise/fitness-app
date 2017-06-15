//
//  Bet.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/13/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import Foundation
import Gloss
import Alamofire

class Bet: Glossy, Decodable, Encodable {
    var betString: String!
    
    init() {
        betString = ""
    }
    
    func setBet(bet: String) {
        betString = bet
    }
    
    required init?(json: JSON) {
        self.betString = "betString" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "betString" ~~> self.betString,
            ])
    }
}
