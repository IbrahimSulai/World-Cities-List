//
//  WorldCityDetailsTableViewCell.swift
//  WorldCitiesList
//
//  Created by Ibrahim on 09/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import UIKit

class WorldCityDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // function to set the UI attributes
    func setUIAttributes() {
        cityNameLabel.font = UIFont.fontBoldWith(size: 18.0)
        populationLabel.font = UIFont.fontMediumWith(size: 14.0)
    }
}
