//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Alina FESYK on 3/18/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit


// Protocol for delegation to WeatherPresenter

protocol ChangeCityDelegate {
    func userEnteredCityName(city: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate: ChangeCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!

    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        guard changeCityTextField.text != "" else { return }
        
        // passing city name to Weather Presenter
        delegate?.userEnteredCityName(city: changeCityTextField.text!)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
