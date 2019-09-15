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
        
        self.view.showBlurLoader();
        
        let entersketSDK = EntersketSDK();
        entersketSDK.getListofCities{ (data)
            in
            self.view.removeBluerLoader();
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

extension UIView {
    func showBlurLoader() {
         DispatchQueue.main.async {
            let blurLoader = BlurLoader(frame: self.frame)
            self.addSubview(blurLoader)
        }
    }
    
    func removeBluerLoader() {
        DispatchQueue.main.async {
            if let blurLoader = self.subviews.first(where: { $0 is BlurLoader }) {
                blurLoader.removeFromSuperview()
            }
        }
    }
}


class BlurLoader: UIView {
    
    var blurEffectView: UIVisualEffectView?
    
    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}
