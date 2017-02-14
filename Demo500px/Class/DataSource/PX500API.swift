//
//  PX500API.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum PX500APIService : Int {
    
    static let kHostUrl = "https://api.500px.com/v1"
    
    case GetPhotos
    
    func path() -> String {
        switch self {
        case .GetPhotos:
            return "/emergencyNews/create"
        }
    }
    
    func fullHost() -> String {
        return "\(PX500APIService.kHostUrl)\(self.path())"
    }
    
    func methodType() -> HTTPMethod {
        switch self {
        case .GetPhotos: return HTTPMethod.get
        }
    }
}

class PX500API: NSObject {
    
    class func buildRequest(service: PX500APIService, bodyDictionary: NSDictionary? = nil) -> URLRequest? {
        if let url = URL(string: service.fullHost()) {
            var request = URLRequest(url: url)
            request.httpMethod = service.methodType().rawValue
            if let bodyDic = bodyDictionary {
                let objectJson = JSON(bodyDic)
                print("RequestBody : \(objectJson)")
                request.httpBody = try! objectJson.rawData()
            }
            return request
        }
        else {
            return nil
        }
    }
}
