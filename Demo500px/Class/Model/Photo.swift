//
//  Photo.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Photo{
    
    var createdAt : String!
    var id : Int!
    var images : [Image]!
    var name : String!
    var user : User!
    
    var imageSquare : String!
    var imageFull : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        id = json["id"].intValue
        images = [Image]()
        let imagesArray = json["images"].arrayValue
        for imagesJson in imagesArray{
            let value = Image(fromJson: imagesJson)
            images.append(value)
            if (value.size == ImageSize.Square280px.rawValue) {
                imageSquare = value.url
            }
            else {
                imageFull = value.url
            }
        }
        name = json["name"].stringValue
        let userJson = json["user"]
        if !userJson.isEmpty{
            user = User(fromJson: userJson)
        }
    }
}
