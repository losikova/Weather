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
        
        Alamofire.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            print(weather)
        }
    }
    
    func loadWeatherData(city: String, completion: @escaping ([Weather]) -> Void ){
        
        // путь для получения погоды за 5 дней
        let path = "/data/2.5/forecast"
        // параметры, город, единицы измерения градусы, ключ для доступа к сервису
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl + path
        
        // делаем запрос
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            
            completion(weather)
        }
        
    }
    
}
