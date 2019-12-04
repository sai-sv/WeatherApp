//
//  WeatherNetworkService.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

enum ForecastType: FinalURLPoint {
    
    case Current(apiKey: String, coordinates: Coordinates)
    
    var baseURL: URL {
        return URL(string: "https://api.darksky.net")!
    }
    
    var path: String {
        switch self {
        case .Current(let apiKey, let coordinates):
            return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}

final class WeatherNetworkService: NetworkService {
    
    var configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    var apiKey: String
    
    init(configuration: URLSessionConfiguration, apiKey: String) {
        self.configuration = configuration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(configuration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchCurrentWeather(coordinates: Coordinates,
                             completionHandler: @escaping (ServiceResponce<WeatherData>) -> Void) {
        let request = ForecastType.Current(apiKey: apiKey, coordinates: coordinates).request
        
        fetch(request: request, parse: { (json) -> WeatherData? in
            guard let dictionary = json["currently"] as? JSON else {
                return nil
            }
            return WeatherData(json: dictionary)
        }, completionHandler: completionHandler)
    }
}
