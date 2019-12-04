//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import Foundation
import UIKit
 
struct WeatherData {

    let temperature: Double
    let apparentTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage?    
}

extension WeatherData: JSONDecodable {
    
    init?(json: JSON) {
        guard let temperature = json["temperature"] as? Double,
        let apparentTemperature = json["apparentTemperature"] as? Double,
        let humidity = json["humidity"] as? Double,
        let pressure = json["pressure"] as? Double,
        let icon = json["icon"] as? String else {
            return nil
        }
        
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.humidity = humidity
        self.pressure = pressure
        self.icon = WeatherIconManager.init(rawValue: icon).image
    }
}
