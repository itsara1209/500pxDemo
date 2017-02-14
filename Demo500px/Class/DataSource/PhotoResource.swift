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
        let paramDic = ["feature":feature] as NSDictionary
        if let request = PX500API.buildRequest(service: service, bodyDictionary: paramDic) {
            Alamofire.request(request).responseJSON(completionHandler: { (responseData) in
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
//            callBack.baseCallBackError(error: GlobalFunction.getWording(key: kWording_SYSTEM_ERROR))
        }
    }
}
