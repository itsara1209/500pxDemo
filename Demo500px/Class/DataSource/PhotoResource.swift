//
//  PhotoResource.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhotoResource: NSObject {
    
    func getPhotos(feature: String, completion: ((GetPhotosResponse?, Error?) -> Void)?) {
        
        let service = PX500APIService.GetPhotos
        let param = ["feature":feature
            , "image_size": [ImageSize.Full600px.rawValue, ImageSize.Square280px.rawValue]
            , "consumer_key": "i8luEVkMohnaMs9nom31zwdrWItAhICuGjzj7Udp"
            , "page": 1] as [String : Any]
        if let request = PX500API.buildRequest(service: service, parameters: param) {
            
            request.responseJSON(completionHandler: { (responseData) in
                debugPrint(responseData)
                switch(responseData.result) {
                case .success(let data):
                    let json = JSON(data)
                    let response = GetPhotosResponse(fromJson: json)
                    completion?(response, nil)
                    break
                case .failure(let error):
                    completion?(nil, error)
                    break
                }
            })
        }
        else {
//            completion?(nil, "Error")
        }
    }
}
