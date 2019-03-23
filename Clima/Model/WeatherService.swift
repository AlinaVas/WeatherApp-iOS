//
//  WeatherService.swift
//  Clima
//
//  Created by Alina Fesyk on 3/21/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


// WeatherService deals with Open Weather Map API

struct WeatherService {
    
    fileprivate let weatherUrl = "http://api.openweathermap.org/data/2.5/weather"
    fileprivate let appID = ProcessInfo.processInfo.environment["API_KEY"]
    
    
    // MARK: - Networking
    // API call with location coordinates
    
    func getWeatherData(for location: Location, callback: @escaping (Result<Weather>) -> Void) {
        let parameters = ["lat" : String(location.lat),
                          "lon" : String(location.lon),
                          "appid" : appID!]

        Alamofire.request(weatherUrl, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherResult = self.parseWeatherData(JSON(response.result.value!))
                callback(weatherResult)
            } else {
                if let statusCode = response.response?.statusCode {
                    callback(.failure(.networkingError(statusCode: statusCode)))
                } else {
                    callback(.failure(.custom(message: "Connection issues")))
                }
            }
        }
    }
    
    
    // API call with a city name
    
    func getWeatherData(for cityName: String, callback: @escaping (Result<Weather>) -> Void) {
        let parameters = ["q" : cityName,
                          "appid" : appID!]
        
        Alamofire.request(weatherUrl, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weather = self.parseWeatherData(JSON(response.result.value!))
                callback(weather)
            } else {
                if let statusCode = response.response?.statusCode {
                    callback(.failure(.networkingError(statusCode: statusCode)))
                } else {
                    callback(.failure(.custom(message: "Connection issues")))
                }
            }
        }
    }
    
    
    // MARK: - JSON Parsing
    // this method parses JSON with weather data and converts it to Weather model
    
    fileprivate func parseWeatherData(_ json: JSON) -> Result<Weather> {
        print(json)
        if let temp = json["main"]["temp"].double {
            let temperature = Int(temp - 273.15)
            let city = json["name"].stringValue
            let condition = json["weather"][0]["id"].intValue
            let weatherIconName = Weather.getWeatherIconName(for: condition)
            let weather = Weather(city: city, temperature: temperature, condition: condition, weatherIconName: weatherIconName)
            return .success(weather)
        } else if let message = json["message"].string {
            return .failure(.custom(message: message))
        } else if let statusCode = json["cod"].int {
            return .failure(.networkingError(statusCode: statusCode))
        } else {
            return .failure(.parsingError)
        }
    }

}
