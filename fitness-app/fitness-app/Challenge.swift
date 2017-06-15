//
//  Challenge.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/13/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import Foundation
import Gloss
import Alamofire

class Challenge: Glossy, Decodable, Encodable{
    var challengeString: String!
    
    init() {
        challengeString = ""
    }
    
    func setChallenge(challenge: String) {
        challengeString = challenge
    }
    
    required init?(json: JSON) {
        self.challengeString = "challengeString" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "challengeString" ~~> self.challengeString,
            ])
    }
}
