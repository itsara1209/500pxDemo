//
//  User.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SwiftyJSON

struct User{
    
    var fullname : String!
    var id : Int!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        fullname = json["fullname"].stringValue
        id = json["id"].intValue
    }
}
