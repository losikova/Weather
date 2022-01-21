//
//  AllCitiesTableViewController.swift
//  Weather
//
//  Created by Анастасия Лосикова on 16.01.2022.
//

import UIKit

class AllCitiesTableViewController: UITableViewController {
    
    var cities = [
        "Moscow",
        "Vladivostok",
        "Omsk",
        "Saint Petersberg"
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

        let city = cities[indexPath.row]
        
        cell.cityName.text = city

        return cell
    }
}
