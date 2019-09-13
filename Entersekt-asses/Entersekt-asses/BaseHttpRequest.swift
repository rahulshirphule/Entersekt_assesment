//
//  BaseHttpRequest.swift
//  Entersekt-asses
//
//  Created by Rahul Shirphule on 2019/09/12.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import UIKit

class BaseHttpRequest: NSObject {
    
    private var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
//    func load(path: String, method: RequestMethod, params: JSON, completion: @escaping (Any?, ServiceError?) -> ()) -> URLSessionDataTask? {
//        // TODO: Add implementation
//    }
    
    func getListOfCities() {
        
        let session = URLSession.shared
        let url = URL(string: "http://www.mocky.io/v2/5b7e8bc03000005c0084c210")!
       
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if(error != nil) {
                print(response?.description as Any);
            } else {
                print(error.debugDescription);
            }
            
        })
        task.resume();

    }
    
}
