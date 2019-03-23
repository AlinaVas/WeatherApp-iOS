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
        print("location updated ")
        switch result {
        case .success(let location):
            print("success")
            weatherService.getWeatherData(for: location) { [unowned self] result in
                print("weather result")
                switch result {
                case .success(let weather):
                    print("weather success")
                    self.viewDelegate?.displayWeather(weather.description)
                case .failure(let error):
                    print("weather fail")
                    self.viewDelegate?.displayError(message: error.description)
                }
            }
        case .failure(let error):
            print("failure")
            viewDelegate?.displayError(message: error.description)
        }
    }
    
    //MARK: - Change City Delegate method
    /***************************************************************/
    
    func userEnteredCityName(city: String) {
        weatherService.getWeatherData(for: city) { [unowned self] result in
            switch result {
            case .success(let weather):
                print("weather success")
                self.viewDelegate?.displayWeather(weather.description)
            case .failure(let error):
                print("weather fail")
                self.viewDelegate?.displayError(message: error.description)
            }
        }
    }

}
