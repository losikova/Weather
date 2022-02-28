//
//  WeatherViewController_1.swift
//  Weather
//
//  Created by Анастасия Лосикова on 21.01.2022.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dayPickerView: WeekDayPicker!
    
    var city = "Moscow"
    
    let reuseIdentifier = "reuseIdentifier"
    var weathers = [Weather]()
    let dateFormatter = DateFormatter()
    let web = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        web.loadWeatherData(city: city) { [weak self] weathers in
            // сохраняем полученные данные в массиве, чтобы коллекция могла получить к ним доступ
            self?.weathers = weathers
            // коллекция должна прочитать новые данные
            self?.collectionView?.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeather" {
            guard let myCitiesController = segue.source as? MyCitiesTableViewController else {return}
            if let indexPath = myCitiesController.tableView.indexPathForSelectedRow {
                self.city = myCitiesController.cities[indexPath.row]
            }
        }
    }
    
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        cell.configure(whithWeather: weathers[indexPath.row])
        
        return cell

    }
    
    
}
