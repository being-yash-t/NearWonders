//
//  LocationManager.swift
//  NearWonders
//
//  Created by Jay Thakur on 27/12/23.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    private override init() {
        super.init()
        locationManager.delegate = self
    }

    var currentLocation: CLLocation?

    func requestLocationAuthorization(always: Bool = false) {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        if always {
            locationManager.requestAlwaysAuthorization() // For always-on location access
        } else {
            locationManager.requestWhenInUseAuthorization() // For when the app is in use
        }
    }

    // MARK: - CLLocationManagerDelegate methods

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            // Handle other authorization statuses as needed
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle errors
        print("Location Manager Error: \(error.localizedDescription)")
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
}
