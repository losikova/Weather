//
//  AllCitiesTableViewCell.swift
//  Weather
//
//  Created by Анастасия Лосикова on 16.01.2022.
//

import UIKit

class AllCitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel! {
        didSet {
            self.cityName.textColor = .yellow
        }
    }
    @IBOutlet weak var cityEmblem: UIImageView! {
        didSet {
            self.cityEmblem.layer.borderColor = UIColor.white.cgColor
            self.cityEmblem.layer.borderWidth = 2
        }
    }
    
    func configure(city: String, emblem: UIImage) {
        self.cityName.text = city
        self.cityEmblem.image = emblem
        
        self.backgroundColor = .black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityName = nil
        self.cityEmblem = nil
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        cityEmblem.clipsToBounds = true
        cityEmblem.layer.cornerRadius = cityEmblem.frame.width / 2
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
