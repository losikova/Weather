//
//  MyCitiesTableViewCell.swift
//  Weather
//
//  Created by Анастасия Лосикова on 16.01.2022.
//

import UIKit

class MyCitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
