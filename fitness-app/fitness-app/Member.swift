//
//  Member.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/13/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import Foundation

class Member {
    var myName: String!
    var myUserID: Int!
    
    init() {
        myName = ""
        myUserID = nil
    }
    
    func setName(name: String) {
        myName = name
    }
    
    func setID(userID: Int) {
        myUserID = userID
    }
}
