//
//  CitiesTableViewController.swift
//  Entersket-ClientApp
//
//  Created by Rahul Shirphule on 2019/09/15.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import UIKit
import Entersekt_asses

class CitiesTableViewController: UITableViewController {

    var cities : [Citys]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        self.tableView.register(CitiesTableViewCell.self, forCellReuseIdentifier: "citiReuseIdentifier")
        
        self.tableView.register(UINib.init(nibName: "CitiTableViewCell", bundle: nil), forCellReuseIdentifier: "citiReuseIdentifier")

        self.title = "Cities";

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128;
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citiReuseIdentifier", for: indexPath) as! CitiesTableViewCell

        // Configure the cell...
//        cell.textLabel?.text = cities[indexPath.row].name;
       
        cell.lblName.text = self.cities[indexPath.row].name;
        
//        cell.btnGetListOfMalls.addTarget(self, action: Selector(("btnGetListOfShopsInCity:")), for: .touchUpInside)
//        cell.btnGetListOfShopsInCity.addTarget(self, action: Selector(("btnGetListOfShopsInCity:")), for: .touchUpInside)

        cell.btnGetListOfMalls.addTarget(self, action: #selector(btnGetListOfMalls), for: .touchUpInside)
        cell.btnGetListOfShopsInCity.addTarget(self, action: #selector(btnGetListOfShopsInCityClicked), for: .touchUpInside)

        cell.btnGetListOfMalls.tag = indexPath.row;
        cell.btnGetListOfShopsInCity.tag = indexPath.row;

        return cell
    }
    
    
    @objc func btnGetListOfShopsInCityClicked(_ sender: UIButton) {
        
        btnGetListOfShopsInCity(index: sender.tag);
    }
    
    @objc func btnGetListOfMalls(_ sender: UIButton) {
        
        self.view.showBlurLoader();

        let index = sender.tag;
        let entersketSDK = EntersketSDK();
        entersketSDK.getListofMallsInCity(cityId: cities[index].id!, { (data)
            in
            self.view.removeBluerLoader();

            if data != nil {
                
                DispatchQueue.main.async {
                    
                    let citiesViewController = MallsTableViewController()
                    citiesViewController.malls = data;
                    citiesViewController.cityId = self.cities[index].id!;
                    citiesViewController.cityName = self.cities[index].name!;
                    self.navigationController?.pushViewController(citiesViewController, animated: true)
                }
                
            } else {
                
            }
        });
        
        
    }
    
    func btnGetListOfShopsInCity(index : Int) {
        
        self.view.showBlurLoader();

        let entersketSDK = EntersketSDK();
        entersketSDK.getListofShopsInCity(cityId: cities[index].id!, { (data)
            in
            self.view.removeBluerLoader();
            if data != nil {
                
                DispatchQueue.main.async {
            
                    let shopsViewController = ShopsTableViewController()
                    shopsViewController.shops = data;
                    shopsViewController.cityId = self.cities[index].id!;
                    shopsViewController.mallName = self.cities[index].name!;
                    self.navigationController?.pushViewController(shopsViewController, animated: true)
                }
                
            } else {
                
            }
        });
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        btnGetListOfMalls(index: indexPath.row);
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
