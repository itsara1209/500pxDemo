//
//  GetCategoriesResponse.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GetCategoriesResponse{
    
    var categories : [Category]!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        categories = [Category]()
        let categoriesArray = json["categories"].arrayValue
        for categoriesJson in categoriesArray{
            let value = Category(fromJson: categoriesJson)
            categories.append(value)
        }
    }
}

