//
//  EntersketSDK.swift
//  Entersekt-asses
//
//  Created by Rahul Shirphule on 2019/09/13.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import Foundation

public class EntersketSDK {
    
    var dataNotAvailable : Bool;
    let baseRequest : BaseHttpRequest;
    
    public init() {
        baseRequest = BaseHttpRequest(url: EntersketCommon.url);
        dataNotAvailable = true;
//        let baseRequest = BaseHttpRequest(url: EntersketCommon.fileName);
//        if Reachability.isConnectedToNetwork(){
//            dataNotAvailable = false;
//            baseRequest.getListOfCities{ (isCityDataAvailable)
//                in
//                if isCityDataAvailable == true {
//                    self.dataNotAvailable = false;
//                }
//            };
//        }else{
//            let citiesObject =  retrieveFromlocally()
//             if  citiesObject != nil {
//                dataNotAvailable = false;
//            } else {
//                dataNotAvailable = false;
//            }
//
//        }
//        retrieveFromlocally()

    }
    
    public func getData(_ completion: @escaping (Root?) -> ()) {
        
        if Reachability.isConnectedToNetwork(){
            baseRequest.getDataFromServer{ (data)
                in
                let responseData = data as Root?;
                if responseData != nil {
                    completion(responseData);
                } else {
                    completion(nil);
                }
            };
        }else{
            let responseData =  retrieveFromlocally();
            if responseData != nil {
                completion(responseData);
            } else {
                completion(nil);
            }
        }
    }
    
    public func getListofCities(_ completion: @escaping ([String]?) -> ()) {
        
        getData{ (data)
            in
            let responseData = data as Root?;
            var city = [String]();
            if responseData != nil {
                for citi in (responseData?.cities)! {
                    city.append(citi.name);
                }
                completion(city);
            } else {
                completion(nil);
            }
        };
        
    }
    
    public func getCity(cityId: String) // -> Cities {
    {
        
    }
    
    public func getListofMallsInCity(cityId: String) {
        
    }
    
    public func getMallInCity(citiyID: String,mallId: String) {
        
    }
    
    public func getListofShopsInMall(mallId: String) {
        
    }
    
    public func getListofShopsInCity(cityId: String) {
        
    }
    
    func retrieveFromlocally() -> Root?  {
        // Get the url of Cities.json in document directory
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil; }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent(EntersketCommon.fileName+".json")
        
        // Read data from .json file and transform data into an Object
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            let decoder = JSONDecoder()
            do {
                let citiesResponce = try decoder.decode(Root.self, from: data) as Root
                return citiesResponce;
            } catch {
                print(error.localizedDescription)
                return nil;
            }
        } catch {
            print(error);
            return nil;
        }
    }
    
}
