//
//  CitiTableViewCell.swift
//  Entersket-ClientApp
//
//  Created by Rahul Shirphule on 2019/09/15.
//  Copyright © 2019 Entersekt. All rights reserved.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var btnGetListOfMalls: UIButton!
    
    @IBOutlet var btnGetListOfShopsInCity: UIButton!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
