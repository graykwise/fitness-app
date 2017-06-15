//
//  League.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/13/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import Foundation
import Gloss
import Alamofire

class League: Glossy, Decodable, Encodable {
    var myName: String!
    var myChallenge = Challenge()
    var myBet = Bet()
    var myMembers = Array<String>()
    
    init() {
        myName = ""
    }
    
    init(name: String, challenge: Challenge, bet: Bet, members: Array<String>) {
        myName = name
        myChallenge = challenge
        myBet = bet
        myMembers = members
    }
    
    required init?(json: JSON) {
        self.myName = "name" <~~ json
        self.myChallenge.challengeString = ("challenge" <~~ json)!
        self.myBet.betString = ("bet" <~~ json)!
        self.myMembers = ("members" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.myName,
            "challenge" ~~> self.myChallenge,
            "bet" ~~> self.myBet,
            "members" ~~> self.myMembers
            ])
    }
}
