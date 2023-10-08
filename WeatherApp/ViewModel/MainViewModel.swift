//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Jakub Rękas on 05/10/2023.
//

import Foundation
import CoreLocation

class MainViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let weatherManager = WeatherManager()
    
    @Published var lastLocation: CLLocation?
    @Published var weather: WeatherModel?
    @Published var searching = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            lastLocation = location
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon) { weather in
                self.weather = weather
                self.searching.toggle()
            } failed: {
                print("Error")
                self.searching.toggle()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getLocalization() {
        searching = true
        locationManager.requestLocation()
    }
    
    func getTemperatureFromCity(city: String) {
        searching = true
        weatherManager.fetchWeather(cityName: city) { weather in
            self.weather = weather
            self.searching.toggle()
        } failed: {
            print("Errooooor")
            self.searching.toggle()
        }

    }
    
}

