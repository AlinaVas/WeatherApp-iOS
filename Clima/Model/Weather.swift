//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Alina FESYK on 3/18/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit

struct Weather {
    
    var city: String
    var temperature: Int
    var condition: Int
    var weatherIconName: String
    
    //Returns Weather properties in a ready-to-display format
    
    var description: (String, String, String) {
        return (city: city, temperature: "\(temperature)°", weatherIconName: weatherIconName)
    }
    
    
    //This method turns a condition code into the name of the weather condition image
    
    static func getWeatherIconName(for condition: Int) -> String {
        switch condition {
        case 0...300:
            return "tstorm1"
        case 301...500:
            return "light_rain"
        case 501...600:
            return "shower3"
        case 601...700:
            return "snow4"
        case 701...771:
            return "fog"
        case 772...799:
            return "tstorm3"
        case 800:
            return "sunny"
        case 801...804:
            return "cloudy2"
        case 900...903, 905...1000:
            return "tstorm3"
        case 903:
            return "snow5"
        case 904:
            return "sunny"
        default:
            return "dunno"
        }
        
    }
}
