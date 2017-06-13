//
//  League.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/13/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import Foundation

class League {
    var myName: String!
    var myChallenge = Challenge()
    var myBet = Bet()
    var myMembers = Array<Member>()
    
    init() {
        myName = ""
    }
    
    init(name: String, challenge: Challenge, bet: Bet, members: Array<Member>) {
        myName = name
        myChallenge = challenge
        myBet = bet
        myMembers = members
    }
}
