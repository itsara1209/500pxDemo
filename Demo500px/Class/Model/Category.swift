//
//  Category.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Category{
    
    var id : Int!
    var name : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}
