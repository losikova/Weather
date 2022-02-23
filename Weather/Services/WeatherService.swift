//
//  WeatherService.swift
//  Weather
//
//  Created by Анастасия Лосикова on 23.02.2022.
//

import Foundation
import Alamofire

class WeatherService {
    let baseUrl = "http://api.openweathermap.org"
    
    let apiKey = "92cabe9523da26194b02974bfcd50b7e"
    
    func loadWeather(for city: String) {
        
        let path = "/data/2.5/forecast"
        
        let params: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        
        let url = baseUrl + path
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { responce in
            print(responce.value)
        }
    }
}
