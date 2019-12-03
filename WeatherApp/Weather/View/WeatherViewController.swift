//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    private var viewModel: WeatherViewModelType?
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refreshAction(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = WeatherViewModel()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        viewModel?.temperature.bind() { [unowned self] in
            guard let temperature = $0 else { return }
            self.temperatureLabel.text = temperature
        }
        
        viewModel?.apparentTemperature.bind() { [unowned self] in
            guard let apparentTemperature = $0 else { return }
            self.apparentTemperatureLabel.text = apparentTemperature
        }
        
        viewModel?.humidity.bind() { [unowned self] in
            guard let humidity = $0 else { return }
            self.humidityLabel.text = humidity
        }
        
        viewModel?.pressure.bind() { [unowned self] in
            guard let pressure = $0 else { return }
            self.pressureLabel.text = pressure
        }
        
        viewModel?.icon.bind() { [unowned self] in
            guard let image = $0 else { return }
            self.imageView.image = image
        }
    }
}
