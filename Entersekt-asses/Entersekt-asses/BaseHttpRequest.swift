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
    let fileName = "Cities";
    
    init(url: String) {
        baseUrl = url;
    }
    
      func getListOfCities() {
        
        let session = URLSession.shared
        let url = URL(string: baseUrl)!
       
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if(error != nil) {
                print(error.debugDescription);
            } else {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(json as Any);
                self.saveCitiesDataFilesSet(fileName: self.fileName, citiesData: data as! Data)
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
    
    func retrieveFromJsonFile()  {
        // Get the url of Persons.json in document directory
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent(fileName+".json")
        
        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            let citiesData = try? JSONSerialization.jsonObject(with: data, options: [])
            print(citiesData as Any);
        } catch {
            print(error);
        }
    }
    
    
}
