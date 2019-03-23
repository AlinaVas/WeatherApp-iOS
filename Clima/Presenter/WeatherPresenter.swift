//
//  WeatherPresenter.swift
//  Clima
//
//  Created by Alina Fesyk on 3/21/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation


// Protocol with requirements for a ViewController delegate

protocol WeatherViewDelegate: class {
    func displayWeather(_ description: (city: String, temperature: String, iconName: String))
    func displayError(message: String)
}


// Presenter for updating WeatherViewController

class WeatherPresenter: LocationServiceDelegate, ChangeCityDelegate {

    weak var viewDelegate: WeatherViewDelegate?
    
    // Properties for retrieving location and weather data
    
    fileprivate let locationService = LocationService()
    fileprivate let weatherService = WeatherService()
    
    init() {
        locationService.delegate = self
    }
    
    
    //MARK: - Location Service Delegate method
    /***************************************************************/
    
    func locationUpdate(with result: Result<Location>) {
        switch result {
        case .success(let location):
            weatherService.getWeatherData(for: location) { [unowned self] result in
                switch result {
                case .success(let weather):
                    self.viewDelegate?.displayWeather(weather.description)
                case .failure(let error):
                    self.viewDelegate?.displayError(message: error.description)
                }
            }
        case .failure(let error):
            viewDelegate?.displayError(message: error.description)
        }
    }
    
    //MARK: - Change City Delegate method
    /***************************************************************/
    
    func userEnteredCityName(city: String) {
        weatherService.getWeatherData(for: city) { [unowned self] result in
            switch result {
            case .success(let weather):
                self.viewDelegate?.displayWeather(weather.description)
            case .failure(let error):
                self.viewDelegate?.displayError(message: error.description)
            }
        }
    }

}
