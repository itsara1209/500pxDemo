//
//  GetPhotosResponse.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GetPhotosResponse{
    
    var currentPage : Int!
    var feature : String!
    var photos : [Photo]!
    var totalItems : Int!
    var totalPages : Int!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        currentPage = json["current_page"].intValue
        feature = json["feature"].stringValue
        photos = [Photo]()
        let photosArray = json["photos"].arrayValue
        for photosJson in photosArray{
            let value = Photo(fromJson: photosJson)
            photos.append(value)
        }
        totalItems = json["total_items"].intValue
        totalPages = json["total_pages"].intValue
    }
}
