//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Alina FESYK on 3/18/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewDelegate {

    // presenter will take care of all business logic and deliver info to WeatherViewController
    var presenter = WeatherPresenter()

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter.viewDelegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            
            // presenter is also a delegate of ChangeCityViewController in order to
            // find weather for entered city name
            let changeCityViewController = segue.destination as! ChangeCityViewController
            changeCityViewController.delegate = presenter
        }
    }
    
    //MARK: - UI updates
    /***************************************************************/
    
    // called to display wearher condition
    
    func displayWeather(_ description: (city: String, temperature: String, iconName: String)) {
        cityLabel.text = description.city
        temperatureLabel.text = description.temperature
        weatherIcon.image = UIImage(named: description.iconName)
    }
    
    // called to display error
    
    func displayError(message: String) {
        cityLabel.text = message
        temperatureLabel.text = ""
        weatherIcon.image = UIImage(named: "dunno")
        
    }
}



