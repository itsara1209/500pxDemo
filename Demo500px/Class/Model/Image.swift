//
//  Image.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Image{
    
    var url : String!
    var size : Int!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        url = json["url"].stringValue
        size = json["size"].intValue
    }
}
