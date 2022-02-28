//
//  AllCitiesTableViewController.swift
//  Weather
//
//  Created by Анастасия Лосикова on 16.01.2022.
//

import UIKit

class AllCitiesTableViewController: UITableViewController {
    
    var cities = [
        (name: "Moscow", emblem: UIImage(named: "MoscowEmblem")),
        (name: "New York", emblem: UIImage(named: "NewYorkEmblem")),
        (name: "London", emblem: UIImage(named: "LondonEmblem")),
        (name: "Saint Petersburg", emblem: UIImage(named: "SaintPetersbergEmblem")),
        (name: "Los Angeles", emblem: UIImage(named: "LosAngelesEmblem")),
        (name: "Oslo", emblem: UIImage(named: "OsloEmblem"))
    ]
    let reuseIdentifier = "CityCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AllCitiesTableViewCell

        let city = self.cities[indexPath.row]
        
        cell.configure(city: city.name, emblem: city.emblem!)
        return cell
    }
}
