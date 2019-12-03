//
//  WeatherViewModelType.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherViewModelType: class {
    
    var location: Box<String?> { get }
    var temperature: Box<String?> { get }
    var apparentTemperature: Box<String?> { get }
    var humidity: Box<String?> { get }
    var pressure: Box<String?> { get }
    var icon: Box<UIImage?> { get }
}
