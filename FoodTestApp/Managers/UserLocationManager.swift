//
//  UserLocationManager.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 01.07.2023.
//

import Foundation
import CoreLocation

class UserLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = UserLocationManager()
    private override init() { }
    
    private let locationManger = CLLocationManager()
    private var completion: ((CLLocation) -> Void)?
    
    func getUserLocationName(completion: @escaping (String?) -> Void) {
        getUserLocation { location in
            self.getLocationName(with: location) { name in
                completion(name)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        locationManger.stopUpdatingLocation()
    }
    
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        locationManger.requestWhenInUseAuthorization()
        locationManger.delegate = self
        locationManger.startUpdatingLocation()
    }
    
    func getLocationName(with location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location,preferredLocale: Locale(identifier: "ru_RU")) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            completion(place.locality)
        }
    }
    
}
