//
//  PX500API.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import Alamofire

enum PX500APIService : Int {
    
    static let kHostUrl = "https://api.500px.com/v1"
    
    case GetPhotos
    
    func path() -> String {
        switch self {
        case .GetPhotos:
            return "/photos"
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
    
    class func buildRequest(service: PX500APIService, parameters: Parameters? = nil) -> DataRequest? {
        return Alamofire.request(service.fullHost(), method: service.methodType(), parameters: parameters, encoding: URLEncoding.default, headers: nil)
    }
}
