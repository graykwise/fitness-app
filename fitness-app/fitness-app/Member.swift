//
//  Member.swift
//  fitness-app
//
//  Created by Grayson Wise on 6/13/17.
//  Copyright © 2017 Dubs Dev. All rights reserved.
//

import Foundation
import Gloss
import Alamofire

class Member: Decodable, Glossy, Encodable {
    var myName: String!
    var myUserID: String!
    var myEmail: String!
    var myLeague: String!
    
    init() {
        myName = ""
        myUserID = ""
        myEmail = ""
        myLeague = ""
    }
    
    func setName(name: String) {
        myName = name
    }
    
    func setID(userID: String) {
        myUserID = userID
    }
    
    required init?(json: JSON) {
        self.myName = "name" <~~ json
        self.myEmail = "email" <~~ json
        self.myUserID = "userID" <~~ json
        self.myLeague = "myLeague" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.myName,
            "email" ~~> self.myEmail,
            "userID" ~~> self.myUserID,
            "myLeague" ~~> self.myLeague
            ])
    }
}
