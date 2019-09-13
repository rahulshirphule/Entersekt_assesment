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
        
        let entersketSDK = EntersketSDK();
        let cities =  entersketSDK.getListofCities();
        print(cities.description);
    }


}

