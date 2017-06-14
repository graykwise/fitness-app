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
    var myEmail: String!
    
    init() {
        myName = ""
        myUserID = nil
        myEmail = ""
    }
    
    func setName(name: String) {
        myName = name
    }
    
    func setID(userID: Int) {
        myUserID = userID
    }
}
