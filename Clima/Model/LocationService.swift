//
//  LocationService.swift
//  Clima
//
//  Created by Alina Fesyk on 3/21/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {
    func locationUpdate(with result: Result<Location>)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate var location: Location? {
        didSet {
            delegate?.locationUpdate(with: .success(location!))
        }
    }
    weak var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        print("location service init")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    // MARK: - CLLocationManagerDelegate methods

    // stops updating after location is found
    // after location's updated, it will be passed to WeatherPresenter (in property observer)
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                self.location = Location(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            }
        }
    }
    
    
    // error is passed to WeatherPresenter in case of location updates failure
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager was unable to retrieve a location value: ", error.localizedDescription)
        delegate?.locationUpdate(with: .failure(.locationUnavailable))
    }
    
    
    // check if the app is authorized to use location services
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            delegate?.locationUpdate(with: .failure(.locationDenied))
        case .restricted:
            delegate?.locationUpdate(with: .failure(.locationRestricted))
        }
    }
    
}
