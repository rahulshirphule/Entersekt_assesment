//
//  EntersketSDK.swift
//  Entersekt-asses
//
//  Created by Rahul Shirphule on 2019/09/13.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import Foundation

public class EntersketSDK {
    
    let baseRequest : BaseHttpRequest;
    
    public init() {
        baseRequest = BaseHttpRequest(url: EntersketCommon.url);
    }
    
    func getData(_ completion: @escaping (Root?) -> ()) {
        
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
    
    public func getCity(cityId: Int,_ completion: @escaping (Cities?) -> ()) {
        
        getData{ (data)
            in
            let responseData = data as Root?;
            var city = Cities();
            if responseData != nil {
                let citiObject = responseData?.cities!.filter{ $0.id == cityId }.first
                city = citiObject!;
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
                let citiObject = responseData?.cities!.filter{ $0.id == cityId }.first
                for mall in (citiObject?.malls)! {
                    malls.append(mall);
                }
                completion(malls);
            } else {
                completion(nil);
            }
        };
        
    }
    
    public func getShopInMall(cityId: Int,mallId: Int,shopId: Int,_ completion: @escaping (Shops?) -> ()) {
        
        getData{ (data)
            in
            let responseData = data as Root?;
            var perticularShop = Shops();
            if responseData != nil {
                let citiObject = responseData?.cities!.filter{ $0.id == cityId }.first
                let mallObject = citiObject?.malls!.filter{ $0.id == mallId }.first
                let shopObject = mallObject?.shops!.filter{ $0.id == shopId }.first
                perticularShop = shopObject!;
                completion(perticularShop);
            } else {
                completion(nil);
            }
        };
    }
    
    public func getListofShopsInMall(cityId: Int,mallId: Int,_ completion: @escaping ([Shops]?) -> ()) {
        
        getData{ (data)
            in
            let responseData = data as Root?;
            var shops = [Shops]();
            if responseData != nil {
                let citiObject = responseData?.cities!.filter{ $0.id == cityId }.first
                let mallObject = citiObject?.malls!.filter{ $0.id == mallId }.first
                
                for shop in (mallObject?.shops)! {
                    shops.append(shop);
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
                let citiObject = responseData?.cities!.filter{ $0.id == cityId }.first
                for mall in (citiObject?.malls)! {
                    for shop in (mall.shops)! {
                        shops.append(shop);
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
