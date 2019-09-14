//
//  ViewController.swift
//  Entersket-ClientApp
//
//  Created by Rahul Shirphule on 2019/09/13.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import UIKit
import Entersekt_asses

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func btnGetListOfCities(_ sender: UIButton) {
        
        let entersketSDK = EntersketSDK();
        entersketSDK.getListofCities{ (data)
            in
            if data != nil {
                
                DispatchQueue.main.async {
                   
                    let citiesViewController = CitiesTableViewController()
                    citiesViewController.cities = data;
                    self.navigationController?.pushViewController(citiesViewController, animated: true)
                }
                
            } else {
                
            }
        };
        
    }
}

