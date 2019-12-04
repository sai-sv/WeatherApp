//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet var viewModel: WeatherViewModel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refreshAction(_ sender: UIButton) {
        fetchCurrentWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        fetchCurrentWeather()
    }
    
    private func bindViewModel() {
        
        viewModel.temperature.bind() { [unowned self] in
            guard let temperature = $0 else { return }
            DispatchQueue.main.sync {
                self.temperatureLabel.text = temperature
            }
        }
        
        viewModel.apparentTemperature.bind() { [unowned self] in
            guard let apparentTemperature = $0 else { return }
            DispatchQueue.main.sync {
                self.apparentTemperatureLabel.text = apparentTemperature
            }
        }
        
        viewModel.humidity.bind() { [unowned self] in
            guard let humidity = $0 else { return }
            DispatchQueue.main.sync {
                self.humidityLabel.text = humidity
            }
        }
        
        viewModel.pressure.bind() { [unowned self] in
            guard let pressure = $0 else { return }
            DispatchQueue.main.sync {
                self.pressureLabel.text = pressure
            }
        }
        
        viewModel.icon.bind() { [unowned self] in
            guard let image = $0 else { return }
            DispatchQueue.main.sync {
                self.imageView.image = image
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func fetchCurrentWeather() {
        viewModel?.fetchCurrentWeather() { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Failure:
                    self?.showAlert(title: "Error", message: "Weather not received!")
                    break
                case .Success:
                    print("Weather Data Recieved Successfully")
                    break
                }
            }
        }
    }
}
