//
//  EntersketSDK.swift
//  Entersekt-asses
//
//  Created by Rahul Shirphule on 2019/09/13.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import Foundation

public class EntersketSDK {
        
    public init() {
        let url = "http://www.mocky.io/v2/5b7e8bc03000005c0084c210";
        let baseRequest = BaseHttpRequest(url: url);
        if Reachability.isConnectedToNetwork(){
            baseRequest.getListOfCities();
            
        }else{
            baseRequest.retrieveFromJsonFile()
        }
        
    }
    
    public func getListofCities() -> [Cities] {
        
        return [Cities(id: "1",name: "nil",malls: Malls(id: "1",name: "nil",shops: Shops(id: "1",name: "nil")))];
        
    }
    
    public func getCity(cityId: String) -> Cities {
        return Cities(id: "1",name: "nil",malls: Malls(id: "1",name: "nil",shops: Shops(id: "1",name: "nil")));
    }
    
    public func getListofMallsInCity(cityId: String) {
        
    }
    
    public func getMallInCity(citiyID: String,mallId: String) {
        
    }
    
    public func getListofShopsInMall(mallId: String) {
        
    }
    
    public func getListofShopsInCity(cityId: String) {
        
    }
    
}
