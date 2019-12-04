//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel: NSObject, WeatherViewModelType {
   
    private var currentWeather: WeatherData =
        WeatherData(temperature: 0.0,
                    apparentTemperature: 0.0,
                    humidity: 0.0,
                    pressure: 0.0,
                    icon: WeatherIconManager.ClearDay.image)
    
    private lazy var networkService = WeatherNetworkService(apiKey: "f265c86b35d688b749d1f1f53211b1aa")
    private let coordinates = Coordinates(latitude: 59.9386292, longitude: 30.3141308) // St.Petersburg

    var location: Box<String?> = Box(value: "St.Petersburg")
    var temperature: Box<String?> = Box(value: nil)
    var apparentTemperature: Box<String?> = Box(value: nil)
    var humidity: Box<String?> = Box(value: nil)
    var pressure: Box<String?> = Box(value: nil)
    var icon: Box<UIImage?> = Box(value: nil)
    
    public func fetchCurrentWeather(completion: @escaping (Result) -> Void) {
        networkService.fetchCurrentWeather(coordinates: self.coordinates) { [unowned self] (responce) in
            switch responce {
            case .Failure(let error):
                print(error.localizedDescription)
                completion(.Failure)
                break
            case .Success(let data):
                self.currentWeather = data
                self.temperature.value = "\(Int(5 / 9 * (data.temperature - 32)))˚C"
                self.apparentTemperature.value = "Feels like: \(Int(5 / 9 * (data.apparentTemperature - 32)))˚C"
                self.humidity.value = "\(Int(data.humidity * 100)) %"
                self.pressure.value = "\(Int(data.pressure * 0.750062)) mm"
                self.icon.value = data.icon
                print(self.currentWeather)
                completion(.Success)
                break
            }
        }
    }
}
