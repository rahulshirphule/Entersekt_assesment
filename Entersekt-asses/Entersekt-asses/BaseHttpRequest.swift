//
//  BaseHttpRequest.swift
//  Entersekt-asses
//
//  Created by Rahul Shirphule on 2019/09/12.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import UIKit

class BaseHttpRequest: NSObject {
    
    let baseUrl : String;
    
    init(url: String) {
        baseUrl = url;
    }
    
      func getDataFromServer(_ completion: @escaping (Root?) -> ()) {
        
        let session = URLSession.shared
        let url = URL(string: baseUrl)!
       
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if(error != nil) {
                print(error.debugDescription);
                completion(nil)
            } else {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(json as Any);
                self.saveCitiesDataFilesSet(fileName: EntersketCommon.fileName, citiesData: data!)
                
                let decoder = JSONDecoder()
                do {
                    let citiesResponce = try decoder.decode(Root.self, from: data!) as Root
                    completion(citiesResponce)
                } catch {
                    print(error.localizedDescription)
                    completion(nil);
                }
                
            }
        })
        task.resume();
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func saveCitiesDataFilesSet(fileName: String,citiesData : Data) {
        
        let filename = getDocumentsDirectory().appendingPathComponent(fileName+".json")
        
        do {
            try citiesData.write(to: filename)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
        
    }
    
}
