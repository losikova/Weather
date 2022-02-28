//
//  MyCitiesTableViewController.swift
//  Weather
//
//  Created by Анастасия Лосикова on 16.01.2022.
//

import UIKit

class MyCitiesTableViewController: UITableViewController {
    
    var cities = [String]()
    var reuseIdentifier = "MyCityCell"

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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyCitiesTableViewCell

        let city = cities[indexPath.row]
        cell.cityName.text = city

        return cell
    }
    
    @IBAction func addCity(segue: UIStoryboardSegue) {
        if segue.identifier == "addCity" {
            guard let allCitiesController = segue.source as? AllCitiesTableViewController else {return}
            
            if let indexPath = allCitiesController.tableView.indexPathForSelectedRow {
                let city = allCitiesController.cities[indexPath.row]
                
                if !cities.contains(city.name) {
                    cities.append(city.name)
                    tableView.reloadData()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeather" {
            guard let weatherController = segue.destination as? WeatherViewController else {return}
            guard let myCitiesController = segue.source as? MyCitiesTableViewController else {return}
            if let indexPath = myCitiesController.tableView.indexPathForSelectedRow {
                weatherController.city = myCitiesController.cities[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWeather", sender: nil)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
