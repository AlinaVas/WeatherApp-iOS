//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Alina FESYK on 3/18/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewDelegate {

    var presenter = WeatherPresenter()

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter.viewDelegate = self
    }
    
    func displayWeather(_ description: (city: String, temperature: String, iconName: String)) {
        print("display")
        cityLabel.text = description.city
        temperatureLabel.text = description.temperature
        weatherIcon.image = UIImage(named: description.iconName)
    }
    
    func displayError(message: String) {
        print("error displaying")
        cityLabel.text = message
        temperatureLabel.text = ""
        weatherIcon.image = UIImage(named: "dunno")
        
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    

    
    
    
    
    

   
    
    //Write the updateWeatherData method here:
    

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:

    
    //Write the didFailWithError method here:

    

    

    // sets WeatherPresenter as a delegate of ChangeCityViewController before segue,
    // that way WeatherPresenter will be notified when a new city name is entered
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            
            let changeCityViewController = segue.destination as! ChangeCityViewController
            changeCityViewController.delegate = presenter
        }
    }
    
    
    
    
}



