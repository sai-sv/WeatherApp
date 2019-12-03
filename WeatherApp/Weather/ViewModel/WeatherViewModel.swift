//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel: WeatherViewModelType {
    
    private var currentWeather: WeatherData =
        WeatherData(temperature: 1.0,
                    apparentTemperature: -6.0,
                    humidity: 754.0,
                    pressure: 85.0,
                    icon: WeatherIconManager.ClearDay)
    
    var location: Box<String?> {
        get {
            return Box(value: "St.Petersburg")
        }
    }
    
    var temperature: Box<String?> {
        get {
            let text = "\(Int(self.currentWeather.temperature))˚C"
            return Box(value: text)
        }
    }

    var apparentTemperature: Box<String?> {
        get {
            let text = "Feels like \(Int(currentWeather.apparentTemperature))˚C"
            return Box(value: text)
        }
    }

    var humidity: Box<String?> {
        get {
            let text = "\(Int(currentWeather.humidity)) mm"
            return Box(value: text)
        }
    }

    var pressure: Box<String?> {
        get {
            let text = "\(Int(currentWeather.pressure))%"
            return Box(value: text)
        }
    }

    var icon: Box<UIImage?> {
        get {
            let image = currentWeather.icon.image
            return Box(value: image)
        }
    }
}
