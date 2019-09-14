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
    
    public func getListofCities(_ completion: @escaping ([Citys]?) -> ()) {
        
        getData{ (data)
            in
            let responseData = data as Root?;
            var city = [Citys]();
            if responseData != nil {
                for citi in (responseData?.cities)! {
                    var obj = Citys();
                    obj.id = citi.id;
                    obj.name = citi.name;
                    city.append(obj);
                }
                completion(city);
            } else {
                completion(nil);
            }
        };
        
    }
    
    public func getCity(cityName: String,_ completion: @escaping (Cities?) -> ()) {
        
        getData{ (data)
            in
            let responseData = data as Root?;
            var city = Cities();
            if responseData != nil {
                for citi in (responseData?.cities)! {
                    if citi.name == cityName {
                        city = citi;
                    }
                }
                completion(city);
            } else {
                completion(nil);
            }
        };
    }
    
    public func getListofMallsInCity(cityId: Int,_ completion: @escaping ([Malls]?) -> ()) {
        
        getData{ (data)
            in
            let responseData = data as Root?;
            var malls = [Malls]();
            if responseData != nil {
                for citi in (responseData?.cities)! {
                    if citi.id == cityId {
                        for mall in (citi.malls)! {
                            malls.append(mall);
                        }
                    }
                }
                completion(malls);
            } else {
                completion(nil);
            }
        };
        
    }
    
    public func getMallInCity(citiyID: String,mallId: String) {
        
    }
    
    public func getListofShopsInMall(cityId: Int,mallId: Int,_ completion: @escaping ([Shops]?) -> ()) {
        
        getData{ (data)
            in
            let responseData = data as Root?;
            var shops = [Shops]();
            if responseData != nil {
                for citi in (responseData?.cities)! {
                    if citi.id == cityId {
                        for mall in (citi.malls)! {
                            if mall.id == mallId {
                                for shop in (mall.shops)! {
                                    shops.append(shop);
                                }
                            }
                        }
                    }
                }
                completion(shops);
            } else {
                completion(nil);
            }
        };
        
    }
    
    public func getListofShopsInCity(cityId: Int,_ completion: @escaping ([Shops]?) -> ()) {
     
        getData{ (data)
            in
            let responseData = data as Root?;
            var shops = [Shops]();
            if responseData != nil {
                for citi in (responseData?.cities)! {
                    if citi.id == cityId {
                        for mall in (citi.malls)! {
                            for shop in (mall.shops)! {
                                shops.append(shop);
                            }
                        }
                    }
                }
                completion(shops);
            } else {
                completion(nil);
            }
        };
        
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
